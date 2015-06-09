class CommentsController < ApplicationController
  def create
    @room = Room.find_by(url_token: params[:room_url_token])
    @comment = @room.comments.new(comment_params)
    @comment.assign_attributes({user_id: current_user.id, author: current_user.nickname, icon_number: current_user.icon_number})
    @comment.save

    if request.xhr?
      render :json => @room.comments.last(100)
    else
    end
  end

  def get_comment
    @room = Room.find_by(url_token: params[:room_url_token])
    render json: @room.comments.last(100)
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
