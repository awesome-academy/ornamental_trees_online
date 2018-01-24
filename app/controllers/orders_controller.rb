class OrdersController < ApplicationController

  def history
    email = params[:email].strip
    token_key = params[:token_key].strip
    time = params[:time].strip

    joinMd5 = "#{email}-#{time}-#{ENV['SECRET_CODE_CREATE_ORDER_FROM_EMAIL']}"
    token_key_calculation = Digest::MD5.hexdigest joinMd5
    token_key_calculation = token_key_calculation.upcase

    time_convert = time.to_i

    user = User.find_by_email(email)

    if user.present? && token_key_calculation == token_key && ((Time.now.to_i - time_convert) < (24 * 3600))
      sign_in user
      redirect_to my_orders_path
    else
      flash[:notice] = 'Please login!'
      redirect_to root_path
    end
  end

  def new
    @order = Order.new
    carts = Cart.new_cart request.session_options[:id]
    carts.each do |cart|
      @order.order_details.build(product_id: cart.product_id, quantity: cart.quantity)
    end
  end

  def create
    if logged_in?
      @order = @current_user.orders.build order_params
      if @order.save!
        flash[:success] = t ".success"
        redirect_to root_url
      else
        redirect_to new_order_url
      end
    else
      redirect_to login_path
    end
  end

  def show
    @order = Order.find_by id: params[:id]
  end
  
  def destroy
    @order = Order.find_by id: params[:id]
    if @order.present?
      @order.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".danger"
    end
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  private
  def order_params
    params.require(:order).permit(:receving_name, :receving_phonenumber,
                                  :receving_address, :status,
                                   order_details_attributes: [:product_id, :quantity])
  end
end
