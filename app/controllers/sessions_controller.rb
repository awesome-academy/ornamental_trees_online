class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      if user.admin?
        redirect_to admin_root_url
        flash[:admin] = t ".admin"
      else
        redirect_to root_url
        flash[:user] = t ".user"
      end
    else
      flash.now[:danger] = t ".danger"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
