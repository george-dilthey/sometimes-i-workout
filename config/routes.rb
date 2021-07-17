Rails.application.routes.draw do
  resources :users

  root :to => "static#index"

  get "/signup", to: "users#new", as: "signup"
  
  get "/login", to: "sessions#login", as: "login"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#logout", as: "logout"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
