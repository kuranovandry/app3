require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'association' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:debitor) }
    it { is_expected.to belong_to(:creditor) }
  end

  describe 'validation' do
    it 'has valid factory' do
      expect(build(:transaction)).to be_valid
    end

    let!(:recipient) { create(:user) }
    let!(:sponsor) { create(:user) }
    let!(:admin) { create(:user) }

    it { is_expected.to validate_presence_of(:debitor_id) }
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_numericality_of(:amount).is_greater_than(0) }

    context 'if creditor is present' do
      let(:transaction_with_sponsor) do
        admin.add_money(sponsor.id, 100, 'Add some money')
        build(:transaction, creditor: sponsor, debitor: recipient, amount: sponsor.balance)
      end

      it { expect(transaction_with_sponsor).to be_valid }
    end

    context 'if creditor is not present' do
      let(:invalid_transaction) { build(:transaction, creditor: admin, debitor: admin) }

      before { allow(subject).to receive(:creditor) { nil } }

      it { is_expected.to validate_presence_of(:user_id) }
      it { is_expected.to validate_presence_of(:memo) }
      it { expect(invalid_transaction).not_to be_valid }
    end
  end
end
