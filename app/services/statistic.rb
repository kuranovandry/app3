class Statistic
  def self.load_daily_statistic
    date = Time.current.to_date
    DailyStatistic.monthly_statistic.each do |stat|
      daily = MonthlyStatistic.where(movie_id: stat.movie_id, date: date)
      if daily.exists?
        daily.update_all(sum: stat.month_sum)
      else
        daily.create(sum: stat.month_sum)
      end
    end
  end
end
