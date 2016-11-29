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
    # Add the data so we can remove it
    before { SongFileEventHandler.new.added(files) }
    subject(:removed) { SongFileEventHandler.new.removed(files) }

    it 'removes the song for the added files' do
      expect { removed }.to change { Song.count }.by(-2)
    end

    it 'does not remove the album for the added files' do
      expect { removed }.not_to change { Album.count }
    end

    it 'does not remove the artist for the added files' do
      expect { removed }.not_to change { Artist.count }
    end
  end
end
