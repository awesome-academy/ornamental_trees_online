Rails.application.routes.draw do

  get "/category", to: "category#index"
  get "/product", to: "product#index"
  get "/about", to: "static_pages#about"

  root to: "static_pages#home"
end
