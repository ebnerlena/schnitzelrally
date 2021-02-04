Rails.application.routes.draw do
  resources :routes do
    resources :game_tasks do
      post :answer, on: :member
    end

    collection do
      post :join
      post :join_route
    end

    member do
      get :map
      get :start
      get :add_task
    end
  end

  devise_for :users

  devise_scope :user do
    get 'logout', to: 'devise/sessions#destroy'
  end

  resources :players
  # get '/about', to: 'pages#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'routes#index'
end
