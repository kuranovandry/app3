class DailyStatistic < ActiveRecord::Base
  belongs_to :movie
  validates_presence_of :movie_id
  validates :movie_id, uniqueness: { scope: :date }
end
