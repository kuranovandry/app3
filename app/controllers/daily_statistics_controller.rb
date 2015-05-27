class DailyStatisticsController < ApplicationController

  def index
    movie = Movie.find(params[:movie_id])
    @daily_statistics = movie.daily_statistics
  end
end
