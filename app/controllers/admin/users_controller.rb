class Admin::UsersController < ApplicationController
  before_action :logged_in_user

  def index
    @user = User.all.paginate(page: params[:page])
  end

  def destroy
    @user = User.find_by id: params[:id]
    if @user.present?
      if @user.destroy
        flash[:success] = t ".success"
        redirect_to admin_users_url
      else
        flash[:danger] = t ".danger"
        redirect_to admin_users_url
      end
    else
      flash[:danger] = t ".danger"
      redirect_to admin_root_url
    end
  end

  private
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

end
