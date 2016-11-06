require 'spec_helper'

describe 'the playlist page', type: :feature do
  let(:playlist) { FactoryGirl.create(:playlist) }

  describe 'when a user is not logged in' do
    before do
      visit playlist_path playlist
    end

    it 'requires a user to be logged in to access the show page' do
      expect(current_path).to eq(signin_path)
    end
  end
  describe 'when the user is logged in' do
    before do
      sign_in_capy FactoryGirl.create(:user)
      visit playlist_path(playlist)
    end
    it 'allows access if the user is logged in' do
      expect(page).to have_content playlist.name
    end
  end
end
