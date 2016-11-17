require 'spec_helper'

describe Album do
  let(:album) { FactoryGirl.create(:album) }
  it 'has a name' do
    expect(album).to respond_to :name
  end

  it 'has a release date' do
    expect(album).to respond_to :release_date
  end

  it 'has a spotify link' do
    expect(album).to respond_to :link
  end

  it 'has songs' do
    expect(album).to respond_to :songs
  end

  it 'removes its songs when its deleted' do
    create(:song, album_id: album.id)
    expect(album.songs.count).to eq(1)
    expect { album.destroy }.to change { Song.count }.by(-1)
  end
end
