class ProductsController < ApplicationController
  def index
  end

  def show
  	@product = Product.find_by(:id)
  end
end
