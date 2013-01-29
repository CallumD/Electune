require 'spec_helper'

describe 'Shuffling a playlist' do
  context 'When there has been no previous shuffle' do
    before(:each) do
     @playlist = FactoryGirl.create(:playlist)
     @playlist.playlist_items.create(song: FactoryGirl.build_stubbed(:song), user: FactoryGirl.build_stubbed(:user))
     @playlist.playlist_items.create(song: FactoryGirl.build_stubbed(:song), user: FactoryGirl.build_stubbed(:user))
    end

    it 'Presents the user with a shuffle link' do
      visit playlist_path @playlist
      expect(page).to have_content('Shuffle')
    end
  end
end
