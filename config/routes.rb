Rails.application.routes.draw do
  resources :workouts
  resources :segments
  
  resources :users, only: [:new, :create] do
    resources :workouts, only: [:index]
    resources :segments, only: [:index]
  end

  root :to => "static#index"
  get "/auth/strava/callback", to: "sessions#strava_omniauth"

  get "/signup", to: "users#new", as: "signup"
  
  get "/login", to: "sessions#login", as: "login"
  post "/login", to: "sessions#create"
  patch "/workout-star", to: "workout#update_stars"

  delete "/logout", to: "sessions#logout", as: "logout"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
