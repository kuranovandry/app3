FactoryGirl.define do
  factory :ticket, class: 'Ticket' do
    movie
    place_number { rand(1..60) }
    price { rand(40..100) }
    session_date { Faker::Date.forward(7) }
    association :reserved_by, factory: :user
  end
end
