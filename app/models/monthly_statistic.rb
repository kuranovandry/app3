class MonthlyStatistic < ActiveRecord::Base
  establish_connection "db2_#{Rails.env}"
end
