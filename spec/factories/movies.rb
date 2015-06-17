FactoryGirl.define do
  factory :movie, class: 'Movie' do
    name { Faker::Company.name }
    description { Faker::Lorem.sentence(3) }
    release_date { Faker::Date.forward(14) }
    skip_tickets true
    duration { rand(41..200) }
    user
  end
end
