require 'spec_helper'

describe PlaylistsController, type: :controller do
  before { sign_in FactoryBot.create(:user) }

  describe 'GET #show' do
    it 'assigns the requested playlist to @playlist' do
      playlist = FactoryBot.create(:playlist)
      get :show, params: { id: playlist }
      expect(assigns(:playlist)).to eq(playlist)
    end

    it 'renders the #show view' do
      get :show, params: { id: FactoryBot.create(:playlist) }
      expect(response).to render_template :show
    end
  end
end
