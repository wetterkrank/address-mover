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

  #This method should crate updates and should call another method calling apis
  def create_updates
    @move = current_user.moves.last
    authorize @move
    @my_providers = current_user.my_providers
    @my_providers.each do |my_provider|
      Update.create(move: @move, provider: my_provider.provider, update_status: "request not sent")
    end
    redirect_to my_providers_path
  end

end
