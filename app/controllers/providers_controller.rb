class ProvidersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    skip_policy_scope
    @providers = Provider.all
  end
end
