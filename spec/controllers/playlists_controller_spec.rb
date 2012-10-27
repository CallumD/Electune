require 'spec_helper'

describe PlaylistsController do
  describe "GET #show" do
  it "assigns the requested playlist to @playlist" do
    playlist = FactoryGirl.create(:playlist)
    get :show, id: playlist
    assigns(:playlist).should eq(playlist)
  end
  
  it "renders the #show view" do
    get :show, id: FactoryGirl.create(:playlist)
    response.should render_template :show
  end
end
end
