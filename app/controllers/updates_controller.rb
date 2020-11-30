# TODO: Do we need the require here at all? Or put it somewhere else for autoload?
require 'net/http'
require 'net/https'
require 'uri'
require 'json'

class UpdatesController < ApplicationController
  def index
    @move = current_user.moves.last # We select the last created move as current
    @updates = policy_scope(Update).where(move: @move)
  end

  # This method creates all updates for the current move
  def create_updates
    @move = current_move
    if @move.present?
      # Checking if user is allowed to start the move
      authorize @move
      @move.updates.destroy_all # if updates_new?
      @my_providers = current_user.my_providers
      @my_providers.each do |my_provider|
        Update.create(move: @move, provider: my_provider.provider, id_sent: my_provider.identifier_value, update_status: Update::STATUS[0])
      end
      redirect_to move_updates_path(@move)
    else
      skip_authorization
      flash[:alert] = "Please make sure your address and date are set."
      redirect_to my_providers_path
    end
  end

  # This method sends out updates
  def send_updates
    @move = current_user.moves.last
    # Checking if user is allowed to commence the move
    authorize @move
    # TODO: refactor with N+1 request (add providers to updates)
    updates = @move.updates
    # Here we should actually do some sending; for now just changing the status
    updates.each do |update|
      update.update_status = Update::STATUS[1]
      update.save
      if update.provider.update_method == "api" && update.provider.api_endpoint.present?
        response = api_send(update)
        logger.debug(response)
      end
    end
    flash[:notice] = "We're sending out messages, please come back later to check the updates."
    redirect_to my_providers_path
  end

  def api_send(update)
    uri = URI(update.provider.api_endpoint)
    header = { 'Content-Type': 'application/json', 'Accept': 'application/json' }
    data = {
      user: {
        customer_number: update.id_sent,
        street_name: update.move.street_name,
        street_number: update.move.street_number,
        zip: update.move.zip,
        city: update.move.city
      }
    }

    # Create and send the HTTP object
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Patch.new(uri, header)
    request.body = data.to_json
    http.request(request)
  end

  def updates_new?
    @move.updates.all? { |update| update.update_status == Update::STATUS[0] }
  end
end
