Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "/users", to: "users#create"
      get "/me", to: "users#me"
      post "/auth/login", to: "auth#login"
      resources :products do
        resources :reviews, only: [ :index, :create ]
      end
      resources :reviews, only: [ :update, :destroy ]
      get "/cart", to: "carts#show"
      resources :cart_items, only: [ :create, :update, :destroy ]
      resources :favourites, only: [ :index, :create, :destroy ]
      resources :orders, only: [ :index, :create ]
    end
  end

  get "up", to: "rails/health#show", as: :rails_health_check
end
