class UpdatesController < ApplicationController
  def index
    @updates = policy_scope(Update).order(created_at: :desc)
    @move = current_user.moves.last #We decided to select the last created move
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
