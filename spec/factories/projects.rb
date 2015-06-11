FactoryGirl.define do
  factory :project, class: 'Project' do
    name { Faker::Company.name }
    description { Faker::Lorem.sentence(3) }
    start_date { Faker::Date.backward(14) }
    end_date { Faker::Date.forward(23) }
    user
  end
end
