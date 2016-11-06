require 'spec_helper'

describe PlaylistsController, type: :controller do
  before { sign_in FactoryGirl.create(:user) }

  describe 'GET #show' do
    it 'assigns the requested playlist to @playlist' do
      playlist = FactoryGirl.create(:playlist)
      get :show, id: playlist
      expect(assigns(:playlist)).to eq(playlist)
    end

    it 'renders the #show view' do
      get :show, id: FactoryGirl.create(:playlist)
      expect(response).to render_template :show
    end
  end
end
