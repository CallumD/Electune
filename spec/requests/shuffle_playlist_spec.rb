require 'spec_helper'

describe 'Shuffling a playlist' do
  context 'When there has been no previous shuffle' do
    before(:each) do
     @playlist = FactoryGirl.create(:playlist)
     @playlist.songs.create(FactoryGirl.attributes_for(:song))
     @playlist.songs.create(FactoryGirl.attributes_for(:song))
    end

    it 'Presents the user with a shuffle link' do
      visit playlist_path @playlist
      expect(page).to have_content('Shuffle')
    end
  end
end
