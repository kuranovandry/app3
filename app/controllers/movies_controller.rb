class MoviesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_movie, except: %i(index create new)
  before_action :get_categories, only: %i(edit new)

  def index
    @movies = Movie.includes(:user)
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = current_user.movies.create(movie_params)
    if @movie.save
      flash[:success] = t('movie.successful_create')
      redirect_to movies_path
    else
      render 'new'
    end
  end

  def destroy
    if @movie.destroy
      flash[:success] = t('movie.successful_destroy')
    else
      flash[:error] = t('movie.error_destroy')
    end
    redirect_to movies_path
  end

  def update
    if @movie.update(movie_params)
      flash[:success] = t('project.successful_update')
      redirect_to movies_path
    else
      render 'edit'
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:name, :description, :release_date, category_ids: [])
  end

  def get_movie
    @movie = Movie.find(params[:id])
  end

  def find_categories
    @categories = Category.all
  end

  def get_categories
    @categories = Category.pluck(:name, :id)
  end


end
