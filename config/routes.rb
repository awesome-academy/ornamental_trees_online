Rails.application.routes.draw do

  get "auth/:provider/callback", to: "sessions#create"
  get "auth/failure", to: redirect("/")
  get "static_pages/about"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/about", to: "static_pages#about"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :products do
    resources :comments, only: [:create, :destroy]
  end
  resources :users, only: [:new, :create, :show, :update]
  resource  :shopping_cart
  resources :orders, only: [:new, :create, :show, :destroy]
  resources :order_details, only: [:create, :destroy]
  namespace :admin do
    root "admin#index"
    resources :users, only: [:index, :show, :destroy]
    resources :products, :categories
    resources :orders, only: [:index, :show, :destroy]
  end

  root "static_pages#home"
end
