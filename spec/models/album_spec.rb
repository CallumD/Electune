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
    expect(album).to respond_to :spotify_link
  end

  it 'has songs' do
    expect(album).to respond_to :songs
  end
end
