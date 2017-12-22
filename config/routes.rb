Rails.application.routes.draw do

  get "static_pages/about"
  get "/signup",      to: "users#new"
  post "/signup",     to: "users#create"
  get "/about",       to: "static_pages#about"
  get    "/login",    to: "sessions#new"
  post    "/login",   to: "sessions#create"
  delete  "/logout",  to: "sessions#destroy"
  post "/products/search", to: "products#search", as: :products_search
  resources :products, only: [:index, :show]
  resources :users
  namespace :admin do
    root "admin#index"
    resources :users
    resources :products
    resources :categories
  end

  root "static_pages#home"
end
