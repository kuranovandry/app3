FactoryGirl.define do
  sequence :email do |_n|
    email { Faker::Internet.email }
  end
end

FactoryGirl.define do
  factory :user, class: 'User' do
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    date_of_birth { Faker::Date.forward(23) }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
