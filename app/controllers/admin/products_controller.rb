class Admin::ProductsController < ApplicationController
  before_action :logged_in_user
  def index
    @products = Product.paginate page: params[:page]
  end

  def new
    @product = Product.new
  end

  def create
    if params[:product][:category_id]
      @category = Category.find_by(id: params[:product][:category_id])
      @product = @category.products.build product_params
      if @product.save
        flash[:success] = t ".success"
        redirect_to admin_products_url
      else
        render :new
      end
    else
      flash[:success] = t ".nocategory"
      render :new
    end
  end

  def destroy
    @product = Product.find_by id: params[:id]
    if @product.present?
      if @product.destroy
        flash[:success] = t ".success"
        redirect_to admin_products_url
      else
        flash[:danger] = t ".danger"
        redirect_to admin_products_url
      end
    else
      flash[:danger] = t ".danger"
      redirect_to admin_root_url
    end
  end

  def edit
    @product = Product.find_by params[:id]
  end

  def update
    @product = Product.find_by params[:id]
    if @product.update_attributes(product_params)
      flash[:success] = t "admin.products.edit.update"
      redirect_to admin_products_url
    else
      render "edit"
    end
  end

  private

  def product_params
    params.require(:product).permit :name, :price, :quantity
  end

  def logged_in_user
      unless logged_in?
        flash[:danger] = t ".pls_login"
        redirect_to login_url
      end
    end
end
