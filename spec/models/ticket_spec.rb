require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'association' do
    it { is_expected.to belong_to(:movie) }
    it { is_expected.to have_many(:cart_items) }
    it { is_expected.to have_many(:order_items) }
  end

  describe 'validations' do
    it 'has valid factory' do
      expect(build(:ticket)).to be_valid
    end

    it { is_expected.to validate_presence_of(:movie) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:place_number) }
    it { is_expected.to validate_numericality_of(:place_number) }
    it { is_expected.to validate_numericality_of(:price) }
    it { is_expected.to validate_uniqueness_of(:place_number) }
  end

  describe '.available_tickets' do
    let(:movie) { create :movie }
    let(:user) { create :user }
    let(:ticket) { create :ticket, bought: true, reserved_by: user }

    it "doesn't have first ticket in available tickets." do
      expect(movie.tickets.available).not_to include(ticket)
    end
  end
end
