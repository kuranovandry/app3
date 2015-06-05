class CategoriesController < ApplicationController

  before_action :get_category, except: %i(index create new)

  def index
    @categories = Category.order('name').page params[:page]
  end

  def new
    @category = Category.new
  end
  
  def create
    @category = Category.create(category_params)
    if @category.save
      flash[:success] = t('category.successful_create')
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t('category.successful_destroy')
    else
      flash[:error] = t('category.error_destroy')
    end
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def get_category
    @category = Category.find(params[:id])
  end
end
