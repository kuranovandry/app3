require 'rails_helper'

describe User do
  describe 'association' do
    it { is_expected.to have_many(:categories) }
    it { is_expected.to have_many(:movies) }
    it { is_expected.to have_many(:projects) }
    it { is_expected.to have_many(:debit_transactions) }
    it { is_expected.to have_many(:credit_transactions) }
    it { is_expected.to have_many(:admin_transactions) }
    it { is_expected.to have_one(:address) }
    it { is_expected.to have_many(:owner_tickets) }
    it { is_expected.to have_many(:orders) }
    it { is_expected.to have_one(:cart) }
  end

  describe 'validation' do
    let(:user) { create(:user) }

    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }

    it 'has valid factory' do
      expect(build(:user)).to be_valid
    end
  end

  let(:recipient) { create(:user) }
  let(:sponsor) { create(:user) }
  let(:admin) { create(:user) }
  let(:money_amount) { 20 }
  let(:memo) {  Faker::Company.catch_phrase }

  describe '.add_money' do
    it { expect{ admin.add_money(sponsor.id, money_amount, memo) }.to change{ sponsor.balance }.by(money_amount) }
  end

  describe '.transfer_money' do
    it 'transfers money to recipient' do
      admin.add_money(sponsor.id, money_amount, memo)
      expect{ sponsor.transfer_money(recipient.id, money_amount) }.to change{ recipient.balance }.by(money_amount)
    end
  end

  describe '.balance' do
    it 'calculates money amount' do
      admin.add_money(sponsor.id, money_amount, memo)
      expect(sponsor.balance).to eq(money_amount)
    end
  end

  describe '#payable?' do
    before { admin.add_money(sponsor.id, money_amount, memo) }

    context "doesn't have money" do
      it { expect(recipient.payable?).to be_falsey }
    end

    context 'has money' do
      it { expect(sponsor.payable?).to be_truthy }
    end
  end

end
