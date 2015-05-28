class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_layout

  private
  def current_user
    if current_user_id = cookies.signed[:current_user_id] || session[:current_user_id]
      @current_user = User.find_by_id(current_user_id)
      session.delete(:current_user_id) unless @current_user
    end
    @current_user
  end
  helper_method :current_user

  def set_layout
    case controller_name
    when "home"
      'home'
    else
      'application'
    end
  end
end
