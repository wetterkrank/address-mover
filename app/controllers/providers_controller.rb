class ProvidersController < ApplicationController

  skip_before_action :authenticate_user!, only: [ :index, :show ]
  def index
    @providers = Provider.all
  end

  def show

  end
end
