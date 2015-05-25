class Broadcast < ActiveRecord::Base
  before_validation do
    platform_check
  end

  before_create do
    nicoliveplayer if platform == "niconico"
  end

  def nicoliveplayer
    lv = self.url.match(/lv[0-9]+/).to_s
    nicoliveplayer_format = "http://live.nicovideo.jp/nicoliveplayer.swf"
    self.player_url = nicoliveplayer_format + "?v=" + lv
  end

  def platform_check
    self.platform = "niconico" if /^http:\/\/live.nicovideo.jp(.+)/ === url
  end
end
