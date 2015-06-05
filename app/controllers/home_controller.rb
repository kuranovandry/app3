class HomeController < ApplicationController
  def index
    @movies = Movie.limit(5)
    @projects = Project.limit(5)
  end
end
