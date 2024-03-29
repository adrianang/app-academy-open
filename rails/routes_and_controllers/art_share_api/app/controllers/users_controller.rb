class UsersController < ApplicationController
  def index
    if params[:username]
      render json: User.where("username LIKE ?", "%#{ params[:username] }%")
    else
      render json: User.all
    end
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: user
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    user = User.find_by(id: params[:id])
    render json: user
  end

  def update
    user = User.find_by(id: params[:id])

    if user.update(user_params)
      render json: user
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find_by(id: params[:id])

    if user.destroy
      render json: user
    else
      render json: "Cannot destroy this user"
    end
  end

  def likes
    liked_by_user = Like.where(user_id: params[:id])
    render json: liked_by_user
  end

  private
  def user_params
    params.require(:user).permit(:username)
  end
end