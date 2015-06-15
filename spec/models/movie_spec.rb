require 'rails_helper'

describe Movie do
  describe 'association' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:categories_movies) }
    it { is_expected.to have_many(:categories).through(:categories_movies) }
    it { is_expected.to have_many(:categories).through(:categories_movies) }
    it { is_expected.to have_many(:tickets) }
  end

  describe '.create_tickets' do
    let(:movie) { create :movie }

    it 'creates 60 tickets for movie' do
      expect { movie.create_tickets }.to change { Ticket.count }.by(60)
    end
  end
end
