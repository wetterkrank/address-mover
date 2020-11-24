class ProvidersController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index]
  def index
    @providers = Provider.all
  end

end
