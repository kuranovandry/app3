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
  end
end
