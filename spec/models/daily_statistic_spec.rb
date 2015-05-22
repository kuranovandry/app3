require 'rails_helper'

RSpec.describe DailyStatistic, type: :model do
  let!(:movie) { create :movie }
  let!(:daily_statistic) { create(:daily_statistic, movie: movie) }

  describe 'association' do
    it { is_expected.to belong_to(:movie) }
    it { is_expected.to validate_presence_of(:movie_id)}
    it { is_expected.to validate_uniqueness_of(:movie_id).scoped_to(:date) }
  end
end
