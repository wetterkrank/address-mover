# TODO: Do we need the require here at all? Or put it somewhere else for autoload?
require 'net/http'
require 'net/https'
require 'uri'
require 'json'
require 'securerandom'

class UpdatesController < ApplicationController
  def index
    @move = current_user.moves.last # We select the last created move as current
    @updates = policy_scope(Update).where(move: @move)
  end

  # This method creates all updates for the current move
  def create_updates
    @move = current_move # current_user.moves.last

    if @move.nil?
      skip_authorization
      flash[:alert] = "Please make sure your new address and move date are set."
      redirect_to my_providers_path
      return
    end

    authorize @move

    my_providers = current_user.my_providers.includes(:provider)
    if some_id_missing?(my_providers)
      flash[:alert] = "Some data required by your providers is missing, please fill it in and try again."
      redirect_to my_providers_path
      return
    end

    @move.updates.destroy_all # if updates_new?
    my_providers.each do |my_pro|
      Update.create(move: @move, provider: my_pro.provider, id_sent: my_pro.identifier_value, update_status: Update::STATUS[0])
    end

    redirect_to move_updates_path(@move)
  end

  # This method sends out updates
  def send_updates
    @move = current_user.moves.last
    authorize @move
    updates = @move.updates.includes(:provider)

    # Here we should actually do some sending; for now just changing the status
    updates.each do |update|
      update.update(update_status: Update::STATUS[1]) # Muahaha
      if update.provider.update_method == "api" && update.provider.api_endpoint.present?
        ApiSendJob.set(wait: 30.seconds).perform_later(update)
        next
      end
      if update.provider.update_method.blank?
        PDF.create(parent: update, uuid: SecureRandom.uuid)
      end
    end

    flash[:notice] = "Hooorray! 🎉 We're informing your providers. Please check the updates below."
    redirect_to my_providers_path
  end

  def some_id_missing?(my_providers)
    my_providers.any? { |my_pro| my_pro.identifier_value.blank? && my_pro.provider.identifier_name.present? }
  end

  def updates_new?
    @move.updates.all? { |update| update.update_status == Update::STATUS[0] }
  end
end
