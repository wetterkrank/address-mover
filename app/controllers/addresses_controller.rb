class AddressesController < ApplicationController

  def index
    @addresses = policy_scope(Address).order(created_at: :desc)
  end

  def show
    @address = Address.find(params[:id])
    authorize @address
  end

  def edit
    authorize @address
  end

  def new
    authorize @address
  end

  def update
    authorize @address
  end

  def create
    authorize @address
  end

  def destroy
    authorize @address
  end
end
