require 'spec_helper'

describe 'Shuffling a playlist', type: :feature do
  context 'When there has been no previous shuffle' do
    before(:each) do
      playlist = FactoryGirl.create(:playlist)
      playlist.playlist_items.create(song: FactoryGirl.create(:song), user: FactoryGirl.create(:user))
      playlist.playlist_items.create(song: FactoryGirl.create(:song), user: FactoryGirl.create(:user))
      sign_in_capy FactoryGirl.create(:user)
      visit playlist_path playlist
    end
    it 'Presents the user with a shuffle link' do
      expect(page).to have_content('Shuffle')
    end
  end
end
