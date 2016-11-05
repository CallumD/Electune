require 'spec_helper'

describe Artist do
  let(:artist) { FactoryGirl.create(:artist) }
  it 'should have a name' do
    artist.should respond_to :name
  end

  it 'should have a spotify link' do
    artist.should respond_to :spotify_link
  end
end
