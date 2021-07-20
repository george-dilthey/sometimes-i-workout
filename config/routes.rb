Rails.application.routes.draw do
  resources :workouts, only: [:new, :create, :show, :edit, :update, :destroy]
  
  resources :users, only: [:new, :create] do
    resources :workouts, only: [:index]
    resources :segments, only: [:index]
  end

  root :to => "static#index"
  get "/auth/strava/callback", to: "sessions#strava_omniauth"

  get "/signup", to: "users#new", as: "signup"
  
  get "/login", to: "sessions#login", as: "login"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#logout", as: "logout"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
