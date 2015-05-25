class SessionsController < ApplicationController
  layout 'sessions'

  def new
    if current_user
      redirect_to :users
    end
  end

  def create
    if user = UserPasswordAuthenticator.verify(params[:nickname], params[:password])
      if params[:remember] == "on"
        cookies.parmanent.signed[:current_user_id] = user.id
      else
        cookies.delete(:current_user_id)
        session[:current_user_id] = user.id
      end
      redirect_to :users
    else
      render action: 'new'
    end
  end

  def destroy
    cookies.delete(:current_user_id)
    session.delete(:current_user_id)
    redirect_to :users
  end
end
