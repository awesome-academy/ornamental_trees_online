Rails.application.routes.draw do

  get    "/login",    to: "sessions#new"
  post    "/login",   to: "sessions#create"
  delete  "/logout",  to: "sessions#destroy"
  get "/signup",      to: "users#new"
  post "/signup",     to: "users#create"
  get "/about",       to: "static_pages#about"
  get    "/login",    to: "sessions#new"
  post    "/login",   to: "sessions#create"
  delete  "/logout",  to: "sessions#destroy"
  resources :products
  resources :users

  root "static_pages#home"
end
