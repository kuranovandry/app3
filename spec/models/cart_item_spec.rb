require 'rails_helper'

RSpec.describe CartItem, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:cart) }
    it { is_expected.to belong_to(:ticket) }
  end

  describe 'validations' do
    it 'has valid factory' do
      expect(build(:cart_item)).to be_valid
    end

    it { is_expected.to validate_presence_of(:cart) }
    it { is_expected.to validate_presence_of(:ticket) }
    it { is_expected.to validate_numericality_of(:quantity) }
  end

  describe '.total' do
    let!(:cart_item) { create :cart_item }
    let(:sum) { cart_item.quantity * cart_item.price }

    it 'calculates total price' do
      expect(cart_item.total).to eq sum
    end
  end
end
