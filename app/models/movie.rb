class Movie < ActiveRecord::Base

  belongs_to :user
  has_many :categories_movies, dependent: :destroy
  has_many :categories, through: :categories_movies
  has_many :uploads, dependent: :destroy
  has_many :daily_statistics, dependent: :destroy
  has_many :monthly_statistics, dependent: :destroy

  paginates_per 5

  def self.to_csv_generator
    movies_fields = %w(id name description)
    CSV.generate do |csv|
      csv << movies_fields
      all.each do |movie|
        csv << movie.attributes.values_at(*movies_fields)
      end
    end
  end
end
