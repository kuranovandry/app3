FactoryGirl.define do
  factory :monthly_statistic, class: 'MonthlyStatistic' do
    date { 1.day.ago }
    sum { Faker::Number.number(10) }
    movie
  end
end
