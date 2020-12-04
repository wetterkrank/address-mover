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

  # This method sends out the updates; at this point they all have status 0 (not sent)
  def send_updates
    @move = current_user.moves.last
    authorize @move
    updates = @move.updates.includes(:provider)

    updates.each do |update|
      case update.provider.update_method
      when "api"
        update.update(update_status: Update::STATUS[1]) # 1 for pending (ie sent but no reply yet)
        ApiSendJob.set(wait: 30.seconds).perform_later(update) if update.provider.api_endpoint.present?
      when "autoconfirm"
        AutoconfirmJob.set(wait: rand(5..10).seconds).perform_later(update) # will set status 2 (confirmed)
      when "pdf"
        update.update(update_status: Update::STATUS[3]) # 3 for declined
        PDF.create(parent: update, uuid: SecureRandom.uuid)
      else
        update.update(update_status: Update::STATUS[1]) # 1 for pending
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
