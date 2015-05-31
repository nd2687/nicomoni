class RoomsController < ApplicationController
  before_action :authorize_user, except: :index
  before_action :check_room_owner, only: :broadcast_create

  def index
    @rooms = Room.published
    if current_user && current_user.active_room?
      @rooms = @rooms.where.not(id: current_user.active_room.id)
    end
  end

  def show
    @room = Room.find_by_url_token(params[:url_token])
    if current_user
      current_user.update(room_url_token: @room.url_token)
    end
    if @room.full? && !@room.users.include?(current_user)
      flash[:alert] = "満員です。"
      redirect_to :rooms
    else
      @broadcast = Broadcast.new unless listener?
      if current_user && !@room.users.include?(current_user)
        flash[:notice] = "入室しました。"
        @room.room_users.create(user: current_user)
      end
    end
    if @room.broadcasts.where(live: true).count > 0
      @live = true
      broadcast_create
    end
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
      @room.owner = current_user
      session[:room_url_token] = @room.url_token
      if @room.save
        redirect_to room_path(url_token: @room.url_token)
      else
        flash.now[:alert] = "エラー"
        render action: 'new'
      end
    end
  end

  def destroy
    current_user.active_room.update(deletable: true)
    flash[:notice] = "Roomを削除しました。"
    redirect_to :rooms
  end

  def exit_room
    @room = Room.find_by(url_token: params[:url_token])
    room_user = current_user.room_users.where(room: @room).first
    room_user.destroy!
    @room.exit
    flash[:notice] = "退室しました。"
    redirect_to :rooms
  end

  def broadcast_create
    if @live
      @urls = @room.broadcasts.where(live: true).map(&:player_url)
    else
      @room = current_user.rooms.find_by(url_token: params[:broadcast][:url_token])
      @broadcast = @room.broadcasts.new(broadcast_params)
      if @broadcast.save
        render json: [ @broadcast ]
      else
        render json: [ false ]
      end
    end
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

  def broadcast_params
    params.require(:broadcast).permit(:url)
  end

  def check_room_owner
    @room = Room.find_by(url_token: params[:broadcast][:url_token])
    unless current_user.owner?(@room)
      flash[:alert] = "Roomのオーナーではありません。"
      redirect_to :rooms
    end
  end

  def listener?
    current_user.owner?(@room) ? false : true
  end
  helper_method :listener?
end
