FactoryGirl.define do
  factory :location, class: 'Location' do
    country { Faker::Address.country }
    city { Faker::Address.city }
    address { Faker::Address.street_name }
  end
end
