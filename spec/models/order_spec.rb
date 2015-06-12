require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:order_items) }
  end

  describe 'validations' do
    it 'has valid factory' do
      expect(build :order).to be_valid
    end

    it { is_expected.to validate_presence_of(:user) }
  end
end
