class ProvidersController < ApplicationController
  before_action :force_json, only: :search

  def index
    skip_policy_scope
    
    if params[:query].present?
      @providers = Provider.search_by_name(params[:query])
      @selected_ids = current_user.my_providers.pluck(:provider_id)
      @search_performed = true
    else
      @providers = Provider.all
      @selected_ids = current_user.my_providers.pluck(:provider_id)
    end
  end

  def search
    skip_authorization
    q = params[:q].downcase
    @providers = Provider.where("name ILIKE ?", "%#{q}%").limit(10)
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

  private
  
  def force_json
    request.format = :json
  end

end
