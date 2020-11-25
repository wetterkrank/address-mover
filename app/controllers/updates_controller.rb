class UpdatesController < ApplicationController
  def index
    @updates = policy_scope(Update).order(created_at: :desc)
    @move = Move.find(params[:move_id])
    @updates = @move.updates
  end

  def show
    authorize @update
  end

  def edit 
    authorize @update
  end

  def new 
    authorize @update
  end

  def update
    authorize @update
  end

  def create
    authorize @update
  end

  def destroy
    authorize @update
  end
end
