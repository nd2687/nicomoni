class UsersController < ApplicationController
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

  def edit_icon
    @user = User.find(params[:id])
  end

  def update_icon
    @user = User.find(params[:id])
    @user.assign_attributes(icon_params)
    if @user.save
      flash[:notice] = "アイコンを変更しました。"
      redirect_to :users
    else
      flash.now[:alert] = "アイコンの変更に失敗しました。"
      render action: 'edit_icon'
    end
  end

  private
  def user_params
    params.require(:user).permit(
      :nickname, :password, :password_confirmation
    )
  end

  def icon_params
    params.require(:user).permit(
      :icon_number
    )
  end
end
