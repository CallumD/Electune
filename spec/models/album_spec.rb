require 'spec_helper'

describe Album do
let(:album) { FactoryGirl.create(:album) }
  it "should have a name" do
    album.should respond_to :name
  end

  it "should have a release date" do
    album.should respond_to :release_date
  end

  it "should have a spotify link" do
    album.should respond_to :spotify_link
  end

  it "should have songs" do
    album.should respond_to :songs
  end
end
