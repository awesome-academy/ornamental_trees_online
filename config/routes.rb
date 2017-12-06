Rails.application.routes.draw do


  get "/category", to: "category#index"
  get "/product", to: "product#index"
  get "/about", to: "static_pages#about"

  root to: "static_pages#home"
  get    "/login",   to: "sessions#new"
  post    "/login",   to: "sessions#create"
  delete  "/logout",  to: "sessions#destroy"

end
