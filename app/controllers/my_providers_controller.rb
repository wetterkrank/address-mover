class MyProvidersController < ApplicationController
  def index
    @my_providers = policy_scope(MyProvider).includes(:provider).order(created_at: :desc)
    @move = current_user.moves.last # Showing the last created move as current
    @updates = @move&.updates # Using the safe navigation operator here, useful in case @move is nil!
    if @move.nil?
      @markers = []
    else
      @markers = [
        {
          lat: @move.geocode.first,
          lng: @move.geocode.second
        }
      ]
    end
  end

  def show
    @my_provider = MyProvider.find(params[:id])
    authorize @my_provider
  end

  def create
    @my_provider = MyProvider.new(strong_params)
    authorize @my_provider
    @my_provider.user = current_user

    if @my_provider.save
      respond_to do |format|
        format.html { redirect_to my_providers_path }
        format.json { render json: {}, status: 200 }
      end
    else
      render_errors
    end
  end

  def edit
    @my_provider = MyProvider.find(params[:id])
    authorize @my_provider
  end

  def update
    @my_provider = MyProvider.find(params[:id])
    authorize @my_provider
    @my_provider.update(strong_params)
    redirect_to my_providers_path
  end

  def destroy
    @my_provider = MyProvider.find(params[:id])
    authorize @my_provider
    @my_provider.destroy
    respond_to do |format|
      format.html { redirect_to my_providers_path }
      format.js {}
    end
  end

  # This one receives requests from the list providers, :id refers to provider
  def unselect
    @my_provider = MyProvider.where(user: current_user, provider_id: params[:id]).first
    authorize @my_provider
    if @my_provider.destroy
      render json: {}, status: 200
    else
      render_errors
    end
  end

  # Maybe we should move it to updates controller, just need to figure out how
  # Checks if all updates are in the new (index 0) status
  def updates_new?
    @updates.nil? || @updates.all? { |update| update.update_status == Update::STATUS[0] }
  end
  helper_method :updates_new?

  private

  def strong_params
    params.require(:my_provider).permit(:provider_id, :identifier_value)
  end

  def render_errors
    respond_to do |format|
      format.html { render :new }  # TODO: add error message
      format.json { render json: @my_provider.errors, status: 400 }
    end
  end
end
