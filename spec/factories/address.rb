FactoryGirl.define do
  factory :address, class: 'Address' do
    city { Faker::Address.city }
    postal_code { Faker::Address.zip }
    address { Faker::Address.street_address }
    user
  end
end
