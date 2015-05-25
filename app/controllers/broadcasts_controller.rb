class BroadcastsController < ApplicationController
  layout 'broadcasts'

  def show
    @broadcast = Broadcast.new
  end

  def create
    @broadcast = Broadcast.new(broadcast_params)
    if @broadcast.save
    else
    end
    render json: [ @broadcast ]
  end

  private
  def broadcast_params
    params.require(:broadcast).permit(:url)
  end
end
