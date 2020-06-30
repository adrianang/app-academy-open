class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )

    if user.nil?
      render :new
    else
      user.reset_session_token!
      session[:session_token] = user.session_token
      redirect_to user_url(user) 
    end
  end

  def destroy
    session[:session_token] = ""
    render :new
  end
end