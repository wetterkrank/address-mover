class MovesController < ApplicationController
  def index
    @user = current_user
    @moves = @user.moves
  end

  def show
    @move = Move.find(params[:id])
  end
end
