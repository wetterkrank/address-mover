class MyProvidersController < ApplicationController

    def index 
      @my_providers = policy_scope(MyProvider).order(created_at: :desc)
    end

    def show
      authorize @my_provider
    end

    def edit 
      authorize @my_provider
    end

    def new 
      authorize @my_provider
    end

    def update
      authorize @my_provider
    end

    def create
      authorize @my_provider
    end

    def destroy
      authorize @my_provider
    end
end
