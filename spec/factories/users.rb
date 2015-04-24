FactoryGirl.define do
  sequence :email do |n|
    email { Faker::Internet.email }
  end
end

FactoryGirl.define do
  factory :user, :class => 'User' do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end
end
