class ShoppingCartsController < ApplicationController
  def show
    @carts = Cart.where session_id: request.session_options[:id]
  end

  def create
    session_id = request.session_options[:id]
    cart = Cart.find_by session_id: session_id, product_id: params[:cart][:product_id]
    if cart.nil?
      cart = Cart.new cart_params
      cart.session_id = session_id
      cart.quantity = 1
      cart.save!
    else
      cart.quantity = cart.quantity + 1
      cart.save!
    end
  end

  def destroy
    product_id = params[:product_id]
    if session[:shoppingcart].key?(product_id)
      session[:shoppingcart].delete(product_id)
    end
    redirect_to shopping_cart_path
  end

  private

  def cart_params
    params.require(:cart).permit(:product_id)
  end
end
