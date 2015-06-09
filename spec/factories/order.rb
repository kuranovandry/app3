FactoryGirl.define do
  factory :order, class: 'Order' do
    association :user
  end
end
