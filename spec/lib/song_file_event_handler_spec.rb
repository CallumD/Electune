require 'spec_helper'

describe SongFileEventHandler do
  let(:files) { Dir.glob('spec/fixtures/music_files/*') }

  context '#added' do
    subject(:added) { SongFileEventHandler.new.added(files) }

    it 'adds the album for the added files' do
      expect { added }.to change { Album.count }.by(1)
    end

    it 'adds the artist for the added files' do
      expect { added }.to change { Artist.count }.by(2)
    end

    it 'adds the song for the added files' do
      expect { added }.to change { Song.count }.by(2)
    end
  end

  context '#removed' do
    xit 'removes the song for the added files'
    xit 'does not remove the album for the added files'
    xit 'does not remove the artist for the added files'
  end
end
