# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  get 'updates/index'
  get 'updates/edit'
  devise_for :users
  root to: 'pages#home'

  resources :users do
    resources :moves, only: [ :index, :show ] do
      resources :updates, only: [ :index, :edit ]
    end
  end

  resources :providers, only: [ :index ]
  resources :addresses, only: [ :index, :show ]

end
