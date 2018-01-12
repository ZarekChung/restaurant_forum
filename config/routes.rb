Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:edit, :show, :update, :index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "restaurants#index"

  resources :restaurants, only: [:index, :show] do
    #自己設定rutes
    collection do
      get :feeds    
      get :ranking
    end
    #include id
    member do
      get :dashboard
      #create favorite routes
      post :favorite
      post :unfavorite
      post :like
      post :unlike
    end

    resources :comments, only: [:create, :destroy]
  end
  resources :categories, only: :show

  resources :followships, only: [:create, :destroy]

  namespace :admin do
    resources :restaurants
    resources :categories
    root "restaurants#index"    
  end

end
