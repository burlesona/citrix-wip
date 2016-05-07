class AuthController < ApplicationController
  def get_login
  end

  def post_login
    reset_session
    if user = User.find_by_username(params[:username])
      if user.password_matches?(params[:password])
        session[:user_id] = user.id
        redirect_to root_path, notice: "Logged in!"
        return
      else
        @error_message = "Invalid Password"
      end
    else
      @error_message = "User Not Found"
    end
    render :get_login
  end

  def logout
    reset_session
    redirect_to root_path, notice: "Logged out!"
  end
end
