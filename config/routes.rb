Rails.application.routes.draw do
  get "products/index"
  get "products/show"
  get    "/login",   to: "sessions#new"
  post    "/login",   to: "sessions#create"
  delete  "/logout",  to: "sessions#destroy"
  get "/signup" => "users#new"
  post "/signup", to: "users#create"
  resources :users
end
