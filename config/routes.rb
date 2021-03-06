Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "restaurants#index"
  resources :restaurants, only: [:index, :show] do 
    resources :comments, only: [:create, :destroy]

    #瀏覽所有餐廳的最新動態
    collection do
      get :feeds
      #十大熱門餐廳
      get :ranking
    end

    #瀏覽個別餐廳的Dashboard
    member do 
      get :dashboard
      post :favorite
      post :unfavorite
      post :like
      post :unlike
    end
  end
  
  resources :categories, only: :show
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :friend_list
    end
  end

  resources :followships, only: [:create, :destroy]

  resources :friendships, only: [:create, :destroy]
  
  namespace :admin do 
    resources :restaurants
    resources :categories
    root "restaurants#index"
  end
end
