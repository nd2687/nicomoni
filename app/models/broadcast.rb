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

class Broadcast < ActiveRecord::Base
  belongs_to :room

  before_validation do
    platform_check
  end

  before_create do
    nicoliveplayer if platform == "niconico"
    self.live = true if room.present?
  end

  URL = {
    community: "http://com.nicovideo.jp/community/",
    community_thumbnail: "http://icon.nimg.jp/community/s/"
  }

  def get_id
    self.url.match(/lv[0-9]+/).to_s
  end

  def get_community(api)
    status = api.get_player_status(get_id)
    return status[:stream][:default_community]
  end

  def get_base_time(api)
    status = api.get_player_status(get_id)
    time = Time.at(status[:stream][:base_time].to_i).strftime('%H:%M:%S')
    return time + "~"
  end

  private
  def nicoliveplayer
    id = get_id
    nicoliveplayer_format = "http://live.nicovideo.jp/nicoliveplayer.swf"
    nicoliveplayer_format.freeze
    self.player_url = nicoliveplayer_format + "?v=" + id
  end

  def platform_check
    if /^http:\/\/live.nicovideo.jp(.+)/ === url
      self.platform = "niconico"
    else
      self.url = ""
    end
  end
end
