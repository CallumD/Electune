describe SpotifyTrackSearch, "description" do
  it "test" do
    desc_mock = double("desc order mock")
    desc_mock.should_receive(:desc).with(:created_at).and_return(subjects)
  end
end
