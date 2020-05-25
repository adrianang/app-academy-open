class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cats = Cat.find_by(id: params[:id])
    
    if @cats
      render :show
    else
      redirect_to cats_url
    end
  end
end