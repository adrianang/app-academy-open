class SessionsController < ApplicationController
  before_action :check_if_logged_in, only: [:new]

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:user_name],
      params[:user][:password]
    )

    if user.nil?
      flash[:alert] = "Credentials are incorrect, that user does not exist. Try again!"
      render :new
    else
      login_user!(user)
      redirect_to "/cats"
    end
  end

  def destroy
    if current_user
      current_user.reset_session_token!
      session[:session_token] = ""
      redirect_to "/cats"
    end
  end

  private
  def check_if_logged_in
    if current_user
      flash[:alert] = "You are already logged in! Please log out first."
      redirect_to "/cats"
    end
  end
end