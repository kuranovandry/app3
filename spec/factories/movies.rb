FactoryGirl.define do
  factory :movie, :class => 'Movie' do
    name { Faker::Company.name }
    description { Faker::Lorem.sentence(3) }
    release_date { Faker::Date.backward(14) }
    image { Faker::Avatar.image }
    skip_tickets true
    user
  end
end
