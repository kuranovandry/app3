require 'rails_helper'
RSpec.describe Purchase do
  describe '.move_from_cart_to_order' do
    let(:cart) { create :cart }
    let!(:user) { create :user, cart: cart }
    let!(:admin) { create(:user) }
    before { create :cart_item, cart: cart }

    it 'moves items from cart to order' do
      admin.add_money(user.id, 200, 'Money for purchase')
      expect{ Purchase.move_from_cart_to_order(user) }.to change{ OrderItem.count }.by(1)
    end
  end
end
