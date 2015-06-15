FactoryGirl.define do
  factory :cart_item, class: 'CartItem' do
    cart
    ticket
    quantity { rand(1..50) }
  end
end
