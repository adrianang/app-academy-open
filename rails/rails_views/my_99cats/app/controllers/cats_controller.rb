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

  def new
    render :new
  end

  def create
    @cats = Cat.new(cat_params)

    if @cats.save
      redirect_to cat_url(@cats)
    else
      render :new
    end
  end

  private
  def cat_params
    params.require(:cat).permit(:name, :sex, :color, :birth_date, :description)
  end
end