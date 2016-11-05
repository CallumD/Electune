require 'spec_helper'

describe Performer do
  let(:performer) { FactoryGirl.create(:performer) }
  it 'should have a song' do
    performer.should respond_to :song
  end
  it 'should have an artist' do
    performer.should respond_to :artist
  end
end
