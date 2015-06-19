require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:cart_items) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it 'has a valid factory' do
      expect(build :cart).to be_valid
    end
  end

  describe '.quantity' do
    let!(:cart_items) { create_pair :cart_item}
    let!(:cart) { create :cart, cart_items: cart_items }
    let(:amount) { cart_items.inject(0){ |rez, item| rez += item.quantity } }

    it 'counts tickets' do
      expect(cart.quantity).to eq amount
    end
  end

  describe '.total_price' do
    let!(:cart_items) { create_pair :cart_item}
    let!(:cart) { create :cart, cart_items: cart_items }
    let(:total_price) { cart_items.inject(0){ |rez, item| rez += item.quantity * item.price } }

    it 'calculates total price' do
      expect(cart.total_price).to eq total_price
    end
  end
end
