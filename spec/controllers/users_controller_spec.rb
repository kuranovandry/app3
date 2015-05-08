require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe UsersController, type: :controller do
  let!(:user) { create(:user) }

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

      it 'assigns users' do
        expect(assigns(:users)).to eq [user]
      end

      it 'renders index' do
        expect(response).to render_template(:index)
      end
    end
  end

  describe 'PUT #update' do
    let!(:attr) { { name: 'test_name', address_attributes: { id: address.id, city: 'New'} } }
    let!(:address) { create(:address, user: user) }

    before :each do
      sign_in :user, user
    end

    it 'updates existing address city' do
      put :update, id: user.id, user: attr
      address.reload
      expect(address.city).to eql 'New'
    end

    it 'updates user city' do
      put :update, id: user.id, user: attr
      user.reload
      expect(user.address.city).to eql 'New'
    end
  end

  describe 'GET #welcome' do
    before :each do
      sign_in :user, user
      get :welcome, id: user.id
    end

    it 'sends email to user' do
      expect(Sidekiq::Extensions::DelayedMailer.jobs.size).to eq 1
    end

    it 'redirects to users page after sending email' do
      expect(response).to redirect_to(users_path)
    end
  end
end
