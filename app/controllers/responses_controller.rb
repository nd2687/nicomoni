class ResponsesController < ApplicationController
  before_action :set_board, :authorize_user

  def index
    @responses = @board.responses
  end

  def new
    @response = @board.responses.new
  end

  def edit
    @response = @board.responses.find(params[:id])
  end

  def create
    @response = @board.responses.new(response_params)
    @response.name = current_user.nickname
    if @response.save
      flash[:notice] = "レスを作成しました。"
      redirect_to [ @board, :responses ]
    else
      flash.now[:alert] = "レスの作成に失敗しました。"
      render action: 'new'
    end
  end

  def update
    @response = @board.responses.find(params[:id])
    if @response.update_attributes(response_params)
      flash[:notice] = "レスを更新しました。"
      redirect_to [ @board, :responses ]
    else
      flash.now[:alert] = "レスの更新に失敗しました。"
      render action: 'edit'
    end
  end

  def destroy
    @response = @board.responses.find(params[:id])
    if @response.destroy
      flash[:notice] = "レスを削除しました。"
    else
      flash[:alert] = "レスの削除に失敗しました。"
    end
    redirect_to [ @board, :responses ]
  end

  private
  def set_board
    @board = Board.find(params[:board_id])
  end

  def response_params
    params.require(:response).permit(
      :comment
    )
  end

  def authorize_user
    unless current_user
      flash[:alert] = "ユーザーログインが必要です。登録していない方は登録してください。"
      redirect_to :rooms
    end
  end
end
