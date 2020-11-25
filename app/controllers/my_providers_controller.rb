class MyProvidersController < ApplicationController

    def index 
      @my_providers = MyProvider.all
    end

    def show
    end

    def new 
      @user = current_user
      @my_provider = MyProvider.new
    end

    def create
      provider_id = strong_params[:provider_id]
      @my_provider = MyProvider.new
      if !provider_id.empty?
        @provider = Provider.find(provider_id)
        @my_provider.provider = @provider
        @my_provider.user = current_user
        @my_provider.save
        if @my_provider.save 
          redirect_to my_provider_path(@my_provider)
        else 
          render :new
        end
      else 
        render :new
      end
    end

    def destroy
    end

    private
    def strong_params
      params.require(:my_provider).permit(:provider_id, :identifier_value)
    end
end
