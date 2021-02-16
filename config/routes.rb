Rails.application.routes.draw do
  resources :routes do
    resources :game_tasks do
      post :answer, on: :member
    end

    collection do
      get :join
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

  resources :players do
    member do
      get :all_tasks
      get :all_routes
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'routes#index'
end
