require 'spec_helper'
describe Song do
  let(:song) { FactoryGirl.create(:song) }

  it "should allow duplicate name" do
    duplicate = FactoryGirl.build(:song)
    duplicate.should be_valid
  end

  it "should not allow empty name" do
    song = FactoryGirl.build(:song, name: '')
    song.should_not be_valid
  end

  it "should not allow name to be blanks" do
    song = FactoryGirl.build(:song, name: '      ')
    song.should_not be_valid
  end

  it "should allow names bigger than 255 characters" do
    song = FactoryGirl.create(:song, name: (0...400).inject(''){|start| start << 'a' })
    song.should be_valid
  end
end
