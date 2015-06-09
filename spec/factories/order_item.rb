FactoryGirl.define do
  factory :order_item, class: 'OrderItem' do
    association :order
    association :order_transaction, factory: :transaction
    association :ticket
    price { rand(40..100) }
  end
end
