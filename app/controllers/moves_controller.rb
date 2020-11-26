class MovesController < ApplicationController
  def index
    @moves = policy_scope(Move).order(created_at: :desc)
  end

  def show
    @move = Move.find(params[:id])
    authorize @move
  end

  def edit
    authorize @move
  end

  def new
    @user = current_user
    @move = Move.new
    authorize @move
  end

  def update
    authorize @move
  end

  def create
    @user = current_user
    @move = Move.new(move_params)
    @move.user = current_user
    authorize @move
    if @move.save
      redirect_to providers_path
    else
      render :new
    end
  end

  def destroy
    authorize @move
  end

  def savemove
    @move = current_user.moves.last
    address = params[:informations][0]
    @move.street_name = address.split(', ')[0]
    @move.street_number = address.split(', ')[1]
    @move.zip = address.split(', ')[2]
    @move.city = address.split(', ')[3]
    @move.moving_date = params[:informations][1]
    provider_name = params[:informations][2]
    @provider = Provider.where(name: provider_name)[0]
    identifier_value = params[:informations][3]
    @move.save
    redirect_to my_providers_path(@my_providers)
  end

  private

  def move_params
    params.require(:move).permit(:moving_date, :street_name, :street_number, :zip, :city)
  end
end
