require 'spec_helper'

describe Performer do
  let(:performer) { FactoryGirl.create(:performer) }
  it 'has a song' do
    expect(performer).to respond_to :song
  end
  it 'has an artist' do
    expect(performer).to respond_to :artist
  end
end
