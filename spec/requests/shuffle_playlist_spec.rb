require 'spec_helper'

describe 'Shuffling a playlist', type: :feature do
  context 'When there has been no previous shuffle' do
    before(:each) do
      playlist = FactoryBot.create(:playlist)
      playlist.playlist_items.create(song: FactoryBot.create(:song), user: FactoryBot.create(:user))
      playlist.playlist_items.create(song: FactoryBot.create(:song), user: FactoryBot.create(:user))
      sign_in_capy FactoryBot.create(:user)
      visit playlist_path playlist
    end
    it 'Presents the user with a shuffle link' do
      expect(page).to have_content('Shuffle')
    end
  end
end
