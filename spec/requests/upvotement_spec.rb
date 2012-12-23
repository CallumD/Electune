require 'spec_helper'

describe "Upvoting" do

  subject { page }

  describe "appearence of upvote link" do
    let(:user) { FactoryGirl.create(:user) }
    let(:playlist) { FactoryGirl.create(:playlist) }

    describe "when created a playlist_item" do
      before do
        playlist.push FactoryGirl.create(:playlist_item, user: user)
        visit playlist_path(playlist)
        sign_in_capy user
      end

      describe "after creating a playlist_item" do
        it "it should not show upote link" do
          page.should_not have_selector('a', text: 'upvote')
        end
      end
    end

    describe "when playlist_item created by someone else" do
      before do
        playlist.push FactoryGirl.create(:playlist_item)
        visit playlist_path(playlist)
        sign_in_capy user
      end

      describe "after creating a playlist_item" do
        it "it should show upote link" do
          page.should have_selector('a', text: 'upvote')
        end
      end
    end

    describe "when vetoing a playlist_item" do
      before do
        playlist_item = FactoryGirl.create(:playlist_item)
        playlist_item.upvote user.id
        playlist_item.veto user.id
        playlist.push playlist_item
        visit playlist_path(playlist)
        sign_in_capy user

      end

      describe "after its already been vetoed" do
        it "it should not show veto link" do
          page.should_not have_selector('a', text: 'veto')
        end
      end
    end

    describe "when vetoing a playlist_item" do
      before do
        playlist.push FactoryGirl.create(:playlist_item)
        playlist.push FactoryGirl.create(:playlist_item)
        visit playlist_path(playlist)
        sign_in_capy user
      end

      describe "after bringing up the playlist" do
        it "it should show the veto link" do
          page.should have_selector('a', text: 'veto')
        end
      end
    end
  end
end
