class MonthlyStatistic < ActiveRecord::Base
  establish_connection "db2_#{Rails.env}".to_sym
  #----------Associations------------
  belongs_to :movie
  validates :movie_id, :date, presence: true
  validate :month_unique?, unless: proc { |object| object.date.nil? && object.movie_id.nil? }

  private

  def month_unique?
    month_exists = MonthlyStatistic.where(movie_id: movie_id).where(date: date.beginning_of_month..date.end_of_month)
    errors.add(:date, 'Statistic for this month already exists') unless month_exists.empty?
  end
end
