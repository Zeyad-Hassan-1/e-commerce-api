Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
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
      post "password/forgot", to: "password_resets#create"
      post "password/reset", to: "password_resets#update"
      get "/confirm-email", to: "confirmations#confirm_email"
      post "resend-confirmation", to: "confirmations#resend"
    end
  end

  get "up", to: "rails/health#show", as: :rails_health_check
  match "*unmatched", to: "application#route_not_found", via: :all
end
