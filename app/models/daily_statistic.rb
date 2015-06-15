class DailyStatistic < ActiveRecord::Base
  belongs_to :movie
  validates :movie_id, presence: true
  validates :movie_id, uniqueness: { scope: :date }
  #----------Class methods------------
  def self.monthly_statistic(date = Time.current.to_date)
    select('daily_statistics.movie_id, SUM(daily_statistics.sum) AS month_sum')
      .where(date: date.beginning_of_month..date.end_of_month)
      .group(:movie_id)
  end
end
