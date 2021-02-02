Rails.application.routes.draw do
  resources :routes do
    
    resources :game_tasks
     
    collection do
      get :join
      post :join_route
      
    end

    member do 
      get :map
      get :start
    end

  end
  
  devise_for :users

  devise_scope :user do
    get 'logout', to: 'devise/sessions#destroy'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'routes#index'
end
