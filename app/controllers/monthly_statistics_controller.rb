class MonthlyStatisticsController < ApplicationController
  def index
    movie = Movie.find(params[:movie_id])
    @monthly_statistics = movie.monthly_statistics
  end
end
