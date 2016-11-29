require 'spec_helper'

describe 'folder listener' do
  before(:all) { Dir['music/*'].each { |file| FileUtils.rm(file) } }

  after(:all) do
    Song.destroy_all
    Album.destroy_all
    Artist.destroy_all
  end

  context 'adding a file' do
    before(:all) do
      FileUtils.cp(
        'spec/fixtures/music_files/Boehm Feat. Grace Grundy - What Is Love.mp3',
        'music'
      )
      sleep 1 # Needed in order for the listener to be hit
    end

    it 'creates a new song' do
      expect(Song.count).to eq(1)
    end

    it 'creates an album' do
      expect(Album.count).to eq(1)
    end

    it 'creates a artist' do
      expect(Artist.count).to eq(1)
    end

    it 'creates a performer relationship' do
      expect(Performer.count).to eq(1)
    end

    context 'then removing a file' do
      before(:all) do
        FileUtils.rm('music/Boehm Feat. Grace Grundy - What Is Love.mp3')
        sleep 1 # Needed in order for the listener to be hit
      end

      it 'removes the song' do
        expect(Song.count).to eq(0)
      end

      it 'leaves the album' do
        expect(Album.count).to eq(1)
      end

      it 'leaves the artist' do
        expect(Artist.count).to eq(1)
      end

      it 'removes a performer relationship' do
        expect(Performer.count).to eq(0)
      end
    end
  end
end
