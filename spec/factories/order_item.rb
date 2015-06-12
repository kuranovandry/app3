FactoryGirl.define do
  factory :order_item, class: 'OrderItem' do
    order
    association :order_transaction, factory: :transaction
    ticket
    price { rand(40..100) }
  end
end
