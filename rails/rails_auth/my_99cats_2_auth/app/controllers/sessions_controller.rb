class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:user_name],
      params[:user][:password]
    )

    if user.nil?
      render json: 'Credentials are incorrect, that user does not exist'
    else
      user.reset_session_token!
      session[:session_token] = user.session_token
      redirect_to "/cats"
    end
  end

  def destroy
  end
end