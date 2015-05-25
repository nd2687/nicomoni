class RoomsController < ApplicationController
  before_action :authorize_user, except: [ :index, :show ]

  layout 'rooms'

  def index
  end

  def show
    @room = Room.find_by_url_token(params[:url_token])
  end

  def new
    if current_user.active_room?
      flash[:alert] = "既にRoomがあります。Roomは一つしか作成できません。"
      redirect_to :rooms
    else
      @room = current_user.rooms.new
    end
  end

  def create
    if current_user.active_room?
      flash[:alert] = "既にRoomがあります。Roomは一つしか作成できません。"
      redirect_to :rooms
    else
      @room = current_user.rooms.new(room_params)
      if @room.save
        redirect_to room_path(url_token: @room.url_token)
      else
        render action: 'new'
      end
    end
  end

  def destroy
    current_user.room.update(deletable: true)
    flash[:notice] = "Roomを削除しました。"
    redirect_to :rooms
  end

  private
  def room_params
    params.require(:room).permit(
      :name, :private, :number
    )
  end

  def authorize_user
    unless current_user
      flash[:alert] = "ユーザーログインが必要です。登録していない方は登録してください。"
      redirect_to :rooms
    end
  end
end
