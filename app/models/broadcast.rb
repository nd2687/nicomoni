class Broadcast < ActiveRecord::Base
  before_validation do
    platform_check
  end

  before_create do
    nicoliveplayer if platform == "niconico"
  end

  private
  def nicoliveplayer
    lv = self.url.match(/lv[0-9]+/).to_s
    nicoliveplayer_format = "http://live.nicovideo.jp/nicoliveplayer.swf"
    nicoliveplayer_format.freeze
    self.player_url = nicoliveplayer_format + "?v=" + lv
  end

  def platform_check
    if /^http:\/\/live.nicovideo.jp(.+)/ === url
      self.platform = "niconico"
    else
      self.url = ""
    end
  end
end
