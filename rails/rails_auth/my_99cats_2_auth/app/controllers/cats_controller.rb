class CatsController < ApplicationController
  before_action :check_if_logged_in, only: [:new]
  before_action :check_if_current_user_owns_cat, only: [:edit, :update]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id

    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  private
  def cat_params
    params.require(:cat).permit(:age, :birth_date, :color, :description, :name, :sex, :user_id)
  end

  def check_if_logged_in
    if !current_user
      flash[:alert] = "You must log in first to add or edit a cat. Please log in!"
      redirect_to "/cats"
    end
  end

  def check_if_current_user_owns_cat
    @cat = current_user.cats.where(id: params[:id]).first

    if @cat.nil?
      flash[:alert] = "Oops, you can only edit your cats!"
      redirect_to cat_url(Cat.find(params[:id]))
    end
  end
end
