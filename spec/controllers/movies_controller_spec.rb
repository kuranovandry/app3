require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  let!(:user) { create(:user) }
  let!(:movie) { create(:movie, user: user)}


  describe 'GET #index' do
    context 'anonymous user' do
      before :each do
        get :index
      end

      it 'redirects to signin page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'logged user'  do
      before :each do
        sign_in :user, user
        get :index
      end

      it 'returns success response' do
        expect(response).to be_success
      end

      it 'assigns movie' do
        expect(assigns(:movies)).to eq [movie]
      end

      it 'renders index' do
        expect(response).to render_template(:index)
      end
    end
  end

  describe "DELETE #destroy" do
    before :each do
      sign_in :user, user
    end

    context 'when user is movie owner' do
      it 'removes movie' do
        expect {
          delete :destroy, id: movie.id
        }.to change { Movie.count }.by(-1)
      end
    end
  end

  describe "PUT #update" do
    before :each do
      sign_in :user, user
    end

    let(:attr) { { name: 'new name' } }

    context  'when user is movie owner' do
      before (:each) do
        put :update, id: movie.id, movie: attr
        movie.reload
      end

      it { expect(response).to redirect_to(movies_path) }
      it { expect(movie.name).to eql attr[:name] }
    end
  end
end
