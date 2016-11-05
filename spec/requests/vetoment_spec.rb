require 'spec_helper'

describe 'When vitoing a song on a playlist', type: :feature do
  let(:playlist) { FactoryGirl.create(:playlist) }
  let(:user) { FactoryGirl.create(:user) }
  let(:song) { FactoryGirl.create(:song) }

  before do
    playlist.playlist_items.create(song: song, user: user)
    playlist.save
    visit playlist_path playlist
    sign_in_capy user
  end

  it 'should not allow vito on currently playling song' do
    page.should have_content(song.name)
    page.should_not have_link('veto')
  end
end
