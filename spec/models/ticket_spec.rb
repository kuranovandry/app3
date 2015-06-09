require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'association' do
    it { is_expected.to belong_to(:movie) }
    it { is_expected.to belong_to(:owner) }
    it { is_expected.to have_many(:cart_items) }
    it { is_expected.to have_many(:order_items) }
  end
  describe 'validations' do
    it 'has valid factory' do
      expect(build(:ticket)).to be_valid
    end
    it { is_expected.to validate_presence_of(:movie) }
    it { is_expected.to validate_presence_of(:owner) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:place_number) }
    it { is_expected.to validate_numericality_of(:place_number).is_greater_than(0).only_integer }
    it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }
    it { is_expected.to validate_uniqueness_of(:place_number) }
  end

  describe '.create_tickets_for_movie' do
    let(:movie) { create :movie }
    let(:ticket) { Ticket }
    it 'creates 60 tickets for movie' do
      expect{ ticket.create_tickets_for_movie(movie) }.to change{ ticket.count }.by(60)
    end
    it 'creates 5 tickets for movie' do
      expect{ ticket.create_tickets_for_movie(movie, 30, 5) }.to change{ ticket.count }.by(5)
    end
  end

  describe '.available_tickets' do
    let(:movie) { create :movie }
    before do
      Ticket.create_tickets_for_movie(movie, 20, 5)
      create :order_item, ticket: first_ticket
    end
    let(:first_ticket) { Ticket.first }
    it "hasn't first ticket in available tickets." do
      expect(Ticket.available_tickets(movie)).not_to include(first_ticket)
    end
  end
end
