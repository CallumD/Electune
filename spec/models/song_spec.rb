require 'spec_helper'
describe Song do
  let(:song) { FactoryGirl.create(:song) }

  it 'allows duplicate name' do
    duplicate = FactoryGirl.build(:song)
    expect(duplicate).to be_valid
  end

  it 'doesnt allow empty name' do
    song = FactoryGirl.build(:song, name: '')
    expect(song).not_to be_valid
  end

  it 'doesnt allow name to be blanks' do
    song = FactoryGirl.build(:song, name: '      ')
    expect(song).not_to be_valid
  end

  it 'allows names bigger than 255 characters' do
    song = FactoryGirl.create(:song, name: (0...400).inject('') { |start| start << 'a' })
    expect(song).to be_valid
  end

  it 'destroys associated performers' do
    song # Calls song create as its lazy loaded
    expect { song.destroy }.to change { Performer.count }.by(-1)
  end
end
