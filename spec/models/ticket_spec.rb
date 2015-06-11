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
    it { is_expected.to validate_numericality_of(:place_number).is_greater_than(0).only_integer }
    it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }
    it { is_expected.to validate_uniqueness_of(:place_number) }
  end

  describe '.available_tickets' do
    let(:movie) { create :movie }
    let(:first_ticket) { Ticket.first }
    let(:user) { create :user }

    before do
      movie.create_tickets(20, 5)
      first_ticket.update_attribute(:bought, true)
      user.reserved_tickets << first_ticket
      create :order_item, ticket: first_ticket
    end

    it "doesn't have first ticket in available tickets." do
      expect(movie.tickets.available).not_to include(first_ticket)
    end
  end
end
