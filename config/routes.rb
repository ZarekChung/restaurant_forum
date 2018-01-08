Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:edit, :show, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "restaurants#index"

  resources :restaurants, only: [:index, :show] do
    #自己設定rutes
    collection do
      get :feeds    
    end
    #include id
    member do
      get :dashboard
    end

    resources :comments, only: [:create, :destroy]
  end
  resources :categories, only: :show

  namespace :admin do
    resources :restaurants
    resources :categories
    root "restaurants#index"    
  end

end
