require 'rails_helper'

describe Project do
  describe 'association' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validation' do
    let(:project) { create(:project) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:start_date) }
    it { is_expected.to validate_presence_of(:end_date) }

    it 'has valid factory' do
      expect(build(:project)).to be_valid
    end
  end
end
