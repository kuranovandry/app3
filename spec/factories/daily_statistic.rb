FactoryGirl.define do
  factory :daily_statistic, class: 'DailyStatistic' do
    date { Faker::Date.backward(14) }
    sum { Faker::Number.number(8) }
    movie
  end
end
