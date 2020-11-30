# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  devise_for :users

  root to: "pages#home"
  get "about", to: "pages#about"
  
  resources :users
  get 'providers/search', to: 'providers#search'
  resources :providers, only: [ :index, :show, :edit, :update, :destroy ]
  resources :my_providers
  delete "my_providers/unselect/:id", to: "my_providers#unselect"

  resources :moves do
    resources :updates, only: [ :index, :edit ]
  end

  post "start", to: "updates#create_updates"
  post "send", to: "updates#send_updates"

  # What's this for? Nicer dashboard URL?
  get '/user' => "my_providers#index", :as => :user_root
end
