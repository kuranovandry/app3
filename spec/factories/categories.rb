FactoryGirl.define do
  factory :category, :class => 'Category' do
    name { Faker::Company.name }
    user
  end
end
