class UsersController < ApplicationController
  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/register'
    end
  end
  
  private

  def user_params
    p = params.require(:user).permit(:name, :email, :password, :password_confirmation)
    p[:email] = p[:email].strip
    p
  end
end
