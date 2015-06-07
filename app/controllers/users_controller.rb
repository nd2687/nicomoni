class UsersController < ApplicationController
  before_action :check_login, only: [ :new, :create ]

  def index
    if current_user
      @friends = current_user.friends
      @followers = current_user.followers
    else
      redirect_to :new_user
    end
  end

  def show
    @user = User.find(params[:id])
    @friends = @user.friends
    @followers = @user.followers
    @friendship = Friendship.find_by(user: current_user, friend: @user)
    if current_user == @user
      redirect_to :users
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
      @user.update_attribute(:lastlogin, Time.now)
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

  def friends
    @user = User.find(params[:id])
    @friends = @user.friends
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers
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

  def check_login
    if current_user
      flash[:alert] = "ログインしています。"
      redirect_to :users
    end
  end
end
