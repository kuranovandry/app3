FactoryGirl.define do
  factory :cart_item, class: 'CartItem' do
    association :cart
    association :ticket
    quantity {rand(1..50)}
  end
end
