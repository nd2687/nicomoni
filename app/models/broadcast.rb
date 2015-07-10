# == Schema Information
#
# Table name: broadcasts
#
#  id         :integer          not null, primary key
#  url        :string(255)      not null
#  platform   :string(255)      not null
#  player_url :string(255)      not null
#  live       :boolean          default(FALSE), not null
#  room_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'open-uri'
require 'json'
class Broadcast < ActiveRecord::Base
  belongs_to :room

  after_initialize do
    platform_check
  end

  before_create do
    nicoliveplayer if niconico?
    twitcasting_player if twitcasting?
    self.live = true if room.present?
  end

  URL = {
    community: "http://com.nicovideo.jp/community/",
    community_thumbnail: "http://icon.nimg.jp/community/s/"
  }

  def get_id
    self.url.match(/lv[0-9]+/).to_s if niconico?
  end

  def get_community(api)
    if niconico?
      status = api.get_player_status(get_id)
      return status[:stream][:default_community]
    end
  end

  def get_base_time(api)
    if niconico?
      status = api.get_player_status(get_id)
      time = Time.at(status[:stream][:base_time].to_i).strftime('%H:%M:%S')
      return time + "~"
    end
  end

  def get_userid
    self.url.split('/')[3].to_s if twitcasting?
  end

  def get_duration
    uri = "http://api.twitcasting.tv/api/livestatus?user=#{get_userid}"
    jsonp = open(uri).read
    payload = jsonp[/{.+}/]
    data = JSON.parse(payload)
    duration = data["duration"].to_i
    start_time = Time.now - duration
    return "#{start_time.strftime("%H:%M:%S")} ~"
  end

  def get_user_icon
    uri = "http://api.twitcasting.tv/api/userstatus?user=#{get_userid}"
    jsonp = open(uri).read
    payload = jsonp[/{.+}/]
    data = JSON.parse(payload)
    return data["image"]
  end

  def niconico?
    platform == "niconico"
  end

  def twitcasting?
    platform == "twitcasting"
  end

  private
  def nicoliveplayer
    id = get_id
    nicoliveplayer_format = "http://live.nicovideo.jp/nicoliveplayer.swf"
    nicoliveplayer_format.freeze
    self.player_url = nicoliveplayer_format + "?v=" + id
  end

  def twitcasting_player
    self.player_url = url
  end

  def platform_check
    if /^http:\/\/live.nicovideo.jp(.+)/ === url
      self.platform = "niconico"
    elsif /^http:\/\/twitcasting.tv(.+)/ === url
      self.platform = "twitcasting"
    else
      self.url = ""
    end
  end
end
