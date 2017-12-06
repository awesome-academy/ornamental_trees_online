class StaticPagesController < ApplicationController
  def home
    @products = Product.all.order("id desc")
  end

  def about
  end
end
