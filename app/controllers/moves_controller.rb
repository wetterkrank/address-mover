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
    authorize @move
  end

  def update
    authorize @move
  end

  def create
    authorize @move
  end

  def destroy
    authorize @move
  end
end
