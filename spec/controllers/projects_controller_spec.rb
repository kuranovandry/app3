require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:project) { create(:project, user: user)}

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

      it 'assigns project' do
        expect(assigns(:projects)).to eq [project]
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

    let!(:another_project) { create(:project) }

    context 'when user is project owner' do
      it 'removes project' do
        expect {
          delete :destroy, id: project.id
        }.to change { Project.count }.by(-1)
      end
    end

    context 'when user is not project owner' do
      it 'does not remove project' do
        expect {
          delete :destroy, id: another_project.id
        }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "PUT #update" do
    before :each do
      sign_in :user, user
    end

    let!(:another_project) { create(:project) }
    let(:attr) { { name: 'new name' } }

    context  'when user is project owner' do
      before (:each) do
        put :update, id: project.id, project: attr
        project.reload
      end

      it { expect(response).to redirect_to(projects_path) }
      it { expect(project[:name]).to eql attr[:name] }
    end

    context 'when user is not project owner' do
      it 'does not update project' do
        expect {
          put :update, id: another_project.id
        }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "GET #show" do
    before :each do
      sign_in :user, user
    end

    before :each do
      get :show, id: project
    end

    it "assigns project" do
      expect(assigns(:project)).to eq(project)
    end
    
    it "renders the #show view" do
      expect(response).to render_template(:show)
    end
  end
end
