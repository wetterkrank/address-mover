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

  private

  def move_params
    params.require(:move).permit(:moving_date, :street_name, :street_number, :zip, :city)
  end
end
