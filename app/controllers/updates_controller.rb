class UpdatesController < ApplicationController
  def index
    @move = Move.find(params[:move_id])
    @updates = @move.updates
  end

  # def edit
  # end
end
