require 'rails_helper'

describe Movie do
  describe 'association' do
    it { is_expected.to belong_to(:user) }

    it { is_expected.to have_many(:categories).through(:categories_movies) }

    it { is_expected.to have_many(:categories_movies) }
    it { is_expected.to have_many(:uploads) }
    it { is_expected.to have_many(:daily_statistics) }
    it { is_expected.to have_many(:monthly_statistics) }
    it { is_expected.to have_many(:locations) }
    it { is_expected.to have_many(:tickets) }

    it { accept_nested_attributes_for(:locations) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }

    it 'validates numericality of duration' do
      is_expected.to validate_numericality_of(:duration)
        .is_greater_than_or_equal_to(40)
        .is_less_than_or_equal_to(240)
    end
  end

  describe '.create_tickets' do
    let(:movie) { create :movie }

    it 'creates 60 tickets for movie' do
      expect { movie.create_tickets }.to change { Ticket.count }.by(60)
    end
  end

  describe '.to_csv_generator' do
    let(:test_csv) { File.read Rails.root.join('spec', 'fixtures', 'csv', 'movies.csv')  }

    before { create :movie, name: 'Test', description: 'Test' }

    it 'checks csv equality' do
      expect(Movie.to_csv_generator).to eq test_csv
    end
  end
end
