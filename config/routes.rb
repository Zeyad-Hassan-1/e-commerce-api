Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "/users", to: "users#create"
      get "/me", to: "users#me"
      post "/auth/login", to: "auth#login"
      resources :products
    end
  end

  get "up", to: "rails/health#show", as: :rails_health_check
end
