require_relative '../../daemons/current_status'

describe CurrentStatus, "Should expose the desired status for the current web service" do

	let(:current_status) { CurrentStatus.new }

  it "should return none when the playlist has no songs" do
  	playlist = FactoryGirl.build(:playlist)
		CurrentStatus.get_status_for_playlist(playlist).should eq "none"
  end

  it "should return a the first value when a song is added to empty playlist" do
  	Time.stubs(:now).returns("2012-12-03 12:00:00")
  	playlist = FactoryGirl.build(:playlist)
  	playlist.push(FactoryGirl.build(:playlist_item))
  	Time.stubs(:now).returns("2012-12-03 12:00:05")
		CurrentStatus.get_status_for_playlist(playlist).should eq "0:05"
  end

  it "should return a the value up to the song length" do
  	Time.stubs(:now).returns("2012-12-03 12:00:00")
  	playlist = FactoryGirl.build(:playlist)
  	playlist.push(FactoryGirl.build(:playlist_item))
  	Time.stubs(:now).returns("2012-12-03 12:01:00")
		CurrentStatus.get_status_for_playlist(playlist).should eq "1:00"
  end

  it "should pop the song off the stack when the time is hit" do
  	Time.stubs(:now).returns("2012-12-03 12:00:00")
  	playlist = FactoryGirl.build(:playlist)
  	playlist.push(FactoryGirl.build(:playlist_item))
  	Time.stubs(:now).returns("2012-12-03 12:01:00")
		CurrentStatus.get_status_for_playlist(playlist).should eq "1:00"
		playlist.count.should eq 0
  end

  it "should move to next song when first is complete" do
  	Time.stubs(:now).returns("2012-12-03 12:00:00")
  	playlist = FactoryGirl.build(:playlist)
  	playlist.push(FactoryGirl.build(:playlist_item))
  	playlist.push(FactoryGirl.build(:playlist_item))
  	Time.stubs(:now).returns("2012-12-03 12:00:30")
		CurrentStatus.get_status_for_playlist(playlist).should eq "0:30"
		playlist.count.should eq 2
		Time.stubs(:now).returns("2012-12-03 12:01:25")
		CurrentStatus.get_status_for_playlist(playlist).should eq "0:25"
		playlist.count.should eq 1
  end

  it "should return none when all songs have completed" do
  	Time.stubs(:now).returns("2012-12-03 12:00:00")
  	playlist = FactoryGirl.build(:playlist)
  	playlist.push(FactoryGirl.build(:playlist_item))
   	playlist.push(FactoryGirl.build(:playlist_item))
  	Time.stubs(:now).returns("2012-12-03 12:05:00")
		CurrentStatus.get_status_for_playlist(playlist).should eq "none"
		playlist.count.should eq 0
  end
end
