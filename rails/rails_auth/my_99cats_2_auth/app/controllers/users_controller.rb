class UsersController < ApplicationController
  before_action :check_if_logged_in, only: [:new]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:session_token] = @user.session_token
      redirect_to "/cats"
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end

  def check_if_logged_in
    if current_user
      flash[:alert] = "You are already logged in! Please log out first."
      redirect_to "/cats"
    end
  end
end