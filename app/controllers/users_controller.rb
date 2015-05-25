class UsersController < ApplicationController
  layout 'users'

  def index
    unless current_user
      redirect_to :new_user
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.setting_password = true
    if @user.save
      session[:current_user_id] = @user.id
      flash.notice = "ユーザー作成しました。"
      redirect_to :users
    else
      flash.now[:alert] = "エラー"
      render action: 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(
      :nickname, :password, :password_confirmation
    )
  end
end
