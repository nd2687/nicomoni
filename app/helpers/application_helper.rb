module ApplicationHelper
  def flash_messages
    text = content_tag(:div, flash[:alert], class: "alert alert-error", id: 'flashAlert', role: 'alert') if flash[:alert].present?
    text = content_tag(:div, flash[:notice], class: "alert alert-info", id: 'flashAlert', role: 'alert') if flash[:notice].present?
    text
  end

  def icon_list
    arr = []
    icons_length = Dir.glob(Rails.root.join('public/images/user_icons/user*')).size
    icons_length.times do |i|
      arr << "/images/user_icons/user#{i+1}.png"
    end
    return arr
  end

  def controller_name
    params[:controller]
  end
end
