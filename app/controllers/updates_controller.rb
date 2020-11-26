class UpdatesController < ApplicationController
  def index
    @move = current_user.moves.last # We select the last created move as current
    @updates = policy_scope(Update).where(move: @move)
  end

  # This method creates all updates for the current move
  def create_updates
    @move = current_user.moves.last
    # Checking if user is allowed to start the move
    authorize @move
    @my_providers = current_user.my_providers
    @my_providers.each do |my_provider|
      Update.create(move: @move, provider: my_provider.provider, update_status: Update::STATUS[0])
    end
    redirect_to move_updates_path(@move)
  end

  # This method sends out updates
  def send_updates
    @move = current_user.moves.last
    # Checking if user is allowed to commence the move
    authorize @move
    # Here we should actually do some sending; for now just changing the status
    @move.updates.each do |update|
      update.update_status = Update::STATUS[1]
      update.save
    end
    flash[:notice] = "We're sending out messages, please check your updates later"
    redirect_to my_providers_path
  end
end
