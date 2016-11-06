require 'spec_helper'

describe Artist do
  let(:artist) { FactoryGirl.create(:artist) }
  it 'has a name' do
    expect(artist).to respond_to :name
  end

  it 'has a spotify link' do
    expect(artist).to respond_to :link
  end
end
