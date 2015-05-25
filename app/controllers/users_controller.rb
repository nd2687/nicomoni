class UsersController < ApplicationController
  layout 'users'

  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.setting_password = true
    if @user.save
      redirect_to :users
    else
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
