class MovesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @moves = @user.moves
  end

  def show
    @move = Move.find(params[:id])
  end
end
