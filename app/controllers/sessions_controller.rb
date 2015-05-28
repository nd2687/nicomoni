class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to :users
    end
  end

  def create
    if user = UserPasswordAuthenticator.verify(params[:nickname], params[:password])
      if params[:remember] == "true"
        cookies.permanent.signed[:current_user_id] = user.id
      else
        cookies.delete(:current_user_id)
        session[:current_user_id] = user.id
      end
      flash.notice = "ログインしました。"
      redirect_to :users
    else
      flash.now[:alert] = "ログインに失敗しました。"
      render action: 'new'
    end
  end

  def destroy
    cookies.delete(:current_user_id)
    session.delete(:current_user_id)
    flash[:notice] = "ログアウトしました。"
    redirect_to :new_session
  end
end
