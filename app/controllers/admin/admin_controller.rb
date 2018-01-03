class Admin::AdminController < ApplicationController
  before_action :logged_in_user

  def index
    @user = User.paginate page: params[:page]
    @products = Product.paginate page: params[:page]
  end

  private
    def logged_in_user
      unless logged_in?
        flash[:danger] =  t ".pls_login"
        redirect_to login_url
      end
    end
end
