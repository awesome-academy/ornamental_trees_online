class ProductsController < ApplicationController
  def index
  end

  def show
  	@product = Product.find_by(params[:id])
  end
end
