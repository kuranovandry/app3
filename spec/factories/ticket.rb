FactoryGirl.define do
  factory :ticket, class: 'Ticket' do
    movie
    place_number { rand(1..60) }
    price { rand(40..100) }
  end
end
