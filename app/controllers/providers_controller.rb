class ProvidersController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]
  def index
    # @providers = Provider.all
    @providers = policy_scope(Provider)
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
