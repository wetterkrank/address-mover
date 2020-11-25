# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :users
  resources :providers, only: [ :index ]
  resources :my_providers, only: [ :index, :show, :new, :create, :destroy ]
  
  resources :addresses
  
  resources :moves, only: [ :index, :show ] do
    resources :updates, only: [ :index, :edit ]
  end
end
