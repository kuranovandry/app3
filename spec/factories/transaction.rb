FactoryGirl.define do
  factory :transaction, class: 'Transaction' do
    association :debitor, factory: :user
    association :user
    amount { rand(1..1000) }
    memo { Faker::Company.catch_phrase }
  end
end
