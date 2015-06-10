class MoviesController < ApplicationController

  before_action :get_movie, except: %i(index create new)
  before_action :authenticate_user!
  before_action :get_categories, only: %i(edit new)

  def index
    movies = Movie.includes(:user).order('name').page(params[:page])
    respond_to do |format|
      format.html do
        @movies = movies.decorate
        render :index
      end
      format.csv { render text: movies.to_csv_generator }
      format.atom do
        @movies = movies
        render action: 'index', layout: false
      end
    end
  end

  def new
    @movie = Movie.new
    @movie.locations.build
  end

  def show
    @movie = Movie.find params[:id]
    @markers = Gmaps4rails.build_markers(@movie.locations) do |location, marker|
      marker.lat location.latitude
      marker.lng location.longitude
    end
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
    params.require(:movie).permit(:name, :description, :release_date, :image, category_ids: [], locations_attributes: [ :id, :country, :city, :address, :zip_code, :latitude, :longitude ])
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
