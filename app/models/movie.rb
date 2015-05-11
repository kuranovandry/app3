class Movie < ActiveRecord::Base

  belongs_to :user
  has_many :categories_movies, dependent: :destroy
  has_many :categories, through: :categories_movies
  paginates_per 5

end
