Rails.application.routes.draw do
  resources :routes do

    collection do
      get :join
      post :join_route
    end

  end

  resources :game_tasks
  
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'routes#index'
end
