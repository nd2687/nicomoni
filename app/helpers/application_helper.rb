module ApplicationHelper
  def flash_messages
    text = content_tag(:div, flash[:alert], class: "alert alert-danger", role: 'alert') if flash[:alert].present?
    text = content_tag(:div, flash[:notice], class: "alert alert-info", role: 'alert') if flash[:notice].present?
    text
  end
end
