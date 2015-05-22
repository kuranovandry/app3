require 'rails_helper'

RSpec.describe MonthlyStatistic, type: :model do

  it 'has valid factory' do
    expect(build(:monthly_statistic)).to be_valid
  end

  describe 'association' do
    it { is_expected.to belong_to(:movie) }
    it { is_expected.to validate_presence_of(:movie_id)}
  end

  describe '#month_unique?' do
    let!(:movie) { create :movie }
    let!(:monthly_statistic_valid) { create(:monthly_statistic, movie: movie) }

    context 'when month is not unique' do
      it 'is invalid' do
        expect(build(:monthly_statistic,  movie_id: movie.id, date: monthly_statistic_valid.date)).to be_invalid
      end
    end
  end
end
