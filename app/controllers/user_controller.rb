class UserController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      #log_in @user
      #flash[:success] = "Welcome to the Sample App!"
      redirect_to 'home'
    else
      render 'new'
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :name, :email, :password, :password_confirmation)
    end
end
