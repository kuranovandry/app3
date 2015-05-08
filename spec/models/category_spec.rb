require 'rails_helper'

describe Category do
  describe 'association' do
    it { is_expected.to belong_to(:user)}
    it { is_expected.to have_many(:categories_movies) }
    it { is_expected.to have_many(:movies).through(:categories_movies)}
  end
end
