class MonthlyStatistic < ActiveRecord::Base
  establish_connection "db2_#{Rails.env}".to_sym
  belongs_to :movie
  validates_presence_of :movie_id
  validate :month_unique?

  private

  def month_unique?
    return if date.nil?
    month_exists = MonthlyStatistic.where(movie_id: movie_id).where(date: date.beginning_of_month..date.end_of_month)
    errors.add(:date, 'Statistic for this month already exists') unless month_exists.empty?
  end
end
