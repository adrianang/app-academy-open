class CommentsController < ApplicationController
  def index
   if params[:user_id] && params[:artwork_id]
      render json: Comment.where({ user_id: params[:user_id], artwork_id: params[:artwork_id] }) 
   elsif params[:user_id] 
      render json: Comment.where(user_id: params[:user_id])
    elsif params[:artwork_id]
      render json: Comment.where(artwork_id: params[:artwork_id])
    else
      render json: Comment.all
    end
  end

  def create
    comment = Comment.new(comment_params)

    if comment.save
      render json: comment
    else
      render json: comment.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    comment = Comment.find_by(id: params[:id])

    if comment.destroy
      render json: comment
    else
      render json: comment.errors.full_messages, status: :unprocessable_entity
    end
  end

  private
  def comment_params
    params.require(:comments).permit(:user_id, :artwork_id, :body)
  end
end