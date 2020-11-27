class MyProvidersController < ApplicationController
  def index
    @my_providers = policy_scope(MyProvider).order(created_at: :desc)
    @move = current_user.moves.last # Showing the last created move as current
    @updates = @move&.updates # Using the safe navigation operator here, useful in case @move is nil!
  end

  def show
    @my_provider = MyProvider.find(params[:id])
    authorize @my_provider
  end

  def edit
    authorize @my_provider
  end

  def new
    @user = current_user
    @my_provider = MyProvider.new
    authorize @my_provider
  end

  def create
    @my_provider = MyProvider.new(strong_params)
    authorize @my_provider
    @my_provider.user = current_user

    if @my_provider.save
      # if we saved the new object successfully
      respond_to do |format|
        format.html { redirect_to my_providers_path }
        format.json { render json: {}, status: 200 }
      end
    else
      render_errors
    end
  end

  def destroy
    # NOTE: to select the correct object, front must send us my_provider.id, not provider.id
    @my_provider = MyProvider.find(params[:id])
    authorize @my_provider
    @my_provider.destroy
    redirect_to my_providers_path
  end

  def unselect
    @my_provider = MyProvider.where(user: current_user, provider_id: params[:id]).first
    authorize @my_provider
    if @my_provider.destroy
      render json: {}, status: 200
    else
      render_errors
    end
  end

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
