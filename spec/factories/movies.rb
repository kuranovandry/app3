FactoryGirl.define do
  factory :movie, :class => 'Movie' do
    name { Faker::Company.name }
    description { Faker::Lorem.sentence(3) }
    release_date { Faker::Date.backward(14) }
    user
  end
end
