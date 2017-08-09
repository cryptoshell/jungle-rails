class UsersController < ApplicationController
  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/', notice: 'Account created successfully!'
    else
      redirect_to '/register', alert: 'Account could not be created!'
    end
  end
  
  private

  def user_params
    p = params.require(:user).permit(:name, :email, :password, :password_confirmation)
    p[:email] = p[:email].strip
    p
  end
end
