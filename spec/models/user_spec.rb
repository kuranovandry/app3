require 'rails_helper'

describe User do
  describe 'association' do
    it { is_expected.to have_many(:categories) }
    it { is_expected.to have_many(:movies) }
    it { is_expected.to have_many(:projects) }
    it { is_expected.to have_one(:address) }
  end

  describe 'validation' do
    let(:user) { create(:user) }

    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:date_of_birth) }

    it 'has valid factory' do
      expect(build(:user)).to be_valid
    end
  end
end
