require 'spec_helper'

describe "Upvoting" do

  subject { page }

  describe "appearence of upvote link" do
    let(:user) { FactoryGirl.create(:user) }
    let(:playlist) { FactoryGirl.create(:playlist) }

    describe "when created a song" do
      before do
        playlist.push FactoryGirl.create(:song, user: user)
        visit playlist_path(playlist)
        sign_in_capy user
      end

      describe "after creating a song" do
        it "it should not show upote link" do
          page.should_not have_selector('a', text: 'upvote')
        end
      end
    end

    describe "when song created by someone else" do
      before do
        playlist.push FactoryGirl.create(:song)
        visit playlist_path(playlist)
        sign_in_capy user
      end

      describe "after creating a song" do
        it "it should show upote link" do
          page.should have_selector('a', text: 'upvote')
        end
      end
    end

    describe "when vetoing a song" do
      before do
        song = FactoryGirl.create(:song)
        song.upvote user.id
        song.veto user.id
        playlist.push song
        visit playlist_path(playlist)
        sign_in_capy user

      end

      describe "after its already been vetoed" do
        it "it should not show veto link" do
          page.should_not have_selector('a', text: 'veto')
        end
      end
    end

    describe "when vetoing a song" do
      before do
        playlist.push FactoryGirl.create(:song)
        visit playlist_path(playlist)
        sign_in_capy user
      end

      describe "after bringing up the playlist" do
        it "it should show the upvote link" do
          page.should have_selector('a', text: 'veto')
        end
      end
    end
  end
end
