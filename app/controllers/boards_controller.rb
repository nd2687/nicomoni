class BoardsController < ApplicationController
  before_action :authorize_user, except: :index

  def index
    @boards = Board.all
  end

  def show
  end

  def new
    @board = Board.new
  end

  def edit
    @board = Board.find(params[:id])
  end

  def create
    @board = Board.new(board_params)
    if @board.save
      flash[:notice] = "板を作成しました。"
      redirect_to :boards
    else
      flash.now[:alert] = "板作成に失敗しました。"
      render action: 'new'
    end
  end

  def update
    @board = Board.find(params[:id])
    if @board.update_attributes(board_params)
      flash[:notice] = "板を更新しました。"
      redirect_to :boards
    else
      flash.now[:alert] = "板の更新に失敗しました。"
      render action: 'edit'
    end
  end

  def destroy
    @board = Board.find(params[:id])
    if @board.destroy
      flash[:notice] = "板を削除しました。"
    else
      flash[:alert] = "板の削除に失敗しました。"
    end
    redirect_to :boards
  end

  private
  def board_params
    params.require(:board).permit(:title)
  end

  def authorize_user
    unless current_user
      flash[:alert] = "ユーザーログインが必要です。登録していない方は登録してください。"
      redirect_to :boards
    end
  end
end
