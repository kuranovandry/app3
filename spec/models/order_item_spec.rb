require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:order) }
    it { is_expected.to belong_to(:ticket) }
    it { is_expected.to belong_to(:order_transaction) }
  end

  describe 'validations' do
    it 'has valid factory' do
      expect(build :order_item).to be_valid
    end

    it { is_expected.to validate_presence_of(:order) }
    it { is_expected.to validate_presence_of(:ticket) }
    it { is_expected.to validate_presence_of(:transaction_id) }

    it { is_expected.to validate_numericality_of(:price) }
  end

end
