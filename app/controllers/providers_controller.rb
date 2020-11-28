class ProvidersController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:index]

  def index
    skip_policy_scope
    @providers = Provider.all
    @selected_ids = current_user.my_providers.pluck(:provider_id)
  end

  def show
    @provider = Provider.find(params[:id])
    authorize @provider
  end

  def edit
    authorize @provider
  end

  def update
    authorize @provider
  end

  def destroy
    authorize @provider
  end
end
