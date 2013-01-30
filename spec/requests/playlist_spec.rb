require 'spec_helper'

describe "the playlist page" do
  before(:each) do
    @playlist = FactoryGirl.create(:playlist)
  end
  it "requires a user to be logged in to access the show page" do
    expect{ visit playlist_path @playlist}.to redirect_to signin_path
  end
  context "when the user is logged in" do
    before { sign_in_capy FactoryGirl.build_stubbed(:user) }
    it "allows access if the user is logged in" do
      expect{ visit playlist_path }.to have_content @playlist.name
    end
  end
end
