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
      authorize @my_provider
    end

    private
    def strong_params
      params.require(:my_provider).permit(:provider_id, :identifier_value)
    end
end
