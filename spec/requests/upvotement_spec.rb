require 'spec_helper'

describe "Upvoting" do

  subject { page }

    describe "appearence of upvote link" do
    let(:user) { FactoryGirl.create(:user) }
    let(:playlist) { FactoryGirl.create(:playlist) }

    describe "when created a song" do
      before do
        playlist.push FactoryGirl.create(:song)
        visit playlist_path(playlist)
        sign_in_capy user
      end

      describe "after creating a song" do
        it "it should not show upote link" do
          page.should_not have_selector('a', text: 'upvote')
        end
      end
    end
  end
end
