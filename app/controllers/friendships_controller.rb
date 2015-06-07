class FriendshipsController < ApplicationController
  def create
    @friendship = Friendship.new(user: current_user, friend_id: params[:user_id])
    if @friendship.save
      flash[:notice] = "フォローしました。"
    else
      flash[:alert] = "エラーによりフォローできませんでした。"
    end
    redirect_to user_path(id: params[:user_id])
  end

  def destroy
    @user = User.find(params[:user_id])
    @friendship = Friendship.find_by(user: current_user, friend: @user)
    if @friendship.destroy
      flash[:notice] = "フォロー解除しました。"
    else
      flash[:alert] = "フォロー解除できませんでした。"
    end
    redirect_to @user
  end
end
