class MoviesController < ApplicationController
  before_action :prepare_movie, except: %i(index create new)
  before_action :prepare_category, only: %i(edit new)

  def index
    movies = Movie.includes(:user).order('name').page(params[:page])
    @movies = movies.decorate
    respond_to do |format|
      format.html
      format.csv { send_data movies.to_csv_generator }
      format.atom do
        @movies = movies
        render action: 'index', layout: false
      end
    end
  end

  def new
    @movie = Movie.new.decorate
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
    @movie = current_user.movies.build(movie_params)
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

  def add_to_the_cart
    current_user.add_to_cart(@movie, params)
    flash[:success] = t('cart_item.successful_create')
    redirect_to movies_path
  end

  def edit
    @movie = @movie.decorate
  end

  private

  def movie_params
    date = params[:movie][:release_date]
    params[:movie][:release_date] = Date.strptime(date, '%m/%d/%Y') if date && !date.empty?
    params.require(:movie).permit(:name,
                                  :description,
                                  :release_date,
                                  :image,
                                  :duration,
                                  category_ids: [],
                                  locations_attributes: %i(id country city address zip_code latitude longitude))
  end

  def prepare_movie
    @movie = Movie.find(params[:id])
  end

  def find_categories
    @categories = Category.all
  end

  def prepare_category
    @categories = Category.pluck(:name, :id)
  end
end
