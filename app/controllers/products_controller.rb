class ProductsController < ApplicationController

  def index
    if params[:sort_product] == "1"
      @products = Product.search_by_name(params[:search_text])
                      .order("price ASC").paginate(page: params[:page])
    elsif params[:sort_product] == "2"
      @products = Product.search_by_name(params[:search_text])
                      .order("price DESC").paginate(page: params[:page])
    else
      @products = Product.search_by_name(params[:search_text])
                      .order_desc.paginate(page: params[:page])
    end
    respond_to do |format|
      format.js {}
    end
  end

  def show
    @product = Product.find_by id: params[:id]
    @comments = @product.comments.paginate page: params[:page]
    if @product
      flash[:success] = t "admin.products.destroy.success"
    else
      flash[:danger] = t "admin.products.destroy.danger"
      redirect_to products_url
    end
  end

  private

  def product_params
    params.require(:product).permit :name, :price, :quantity, :image
  end
end
