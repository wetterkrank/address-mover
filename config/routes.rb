# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#home'
  get 'about', to: 'pages#about'
  post "savemove", to: 'updates#create_updates'

  resources :users
  resources :providers, only: [ :index, :show, :edit, :update, :destroy ]
  resources :my_providers, only: [ :index, :show, :new, :create, :destroy ]

  resources :moves do
    resources :updates, only: [ :index, :edit ]
  end

  # namespace :users do
  #   root :to => "my_providers#index"
  # end

  get '/user' => "my_providers#index", :as => :user_root


end
