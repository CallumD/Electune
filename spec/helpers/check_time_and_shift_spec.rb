require 'spec_helper'

describe CheckTimeAndShift, "checks the play time and shifts the song if required" do
  before(:each) do
    @playlist = FactoryGirl.create(:playlist, start_time: "12/12/12 12:12:12")
    @song = FactoryGirl.create(:song)
    @user = FactoryGirl.create(:user)
    @playlist.playlist_items.create(song: @song, user: @user)
    @playlist.playlist_items.create(song: @song, user: @user)
  end

  describe "when the current time is less than the song time" do
    before(:each) do
      Time.stub!(:now).and_return(Time.mktime(2012,12,12,12,12,30))
    end
    it "should not shift the song off the playlist" do
      count = @playlist.playlist_items.count
      CheckTimeAndShift.tick_on_playlist @playlist.id
      @playlist.playlist_items.count.should eq count
    end
    it "should report the time as the difference between the start time and the current time" do
      difference = Time.now - @playlist.start_time
      response = CheckTimeAndShift.tick_on_playlist @playlist.id
      response.should eq difference
    end
  end

  describe "when the current time is more than the song time" do
    before(:each) do
      Time.stub!(:now).and_return(Time.mktime(2012,12,12,12,13,30))
    end
    it "should shift the current song off the playlist" do
      count = @playlist.playlist_items.count
      CheckTimeAndShift.tick_on_playlist @playlist.id
      @playlist.playlist_items.count.should eq(count - 1)
    end

    it "should set the playlist start time to the previous start time plus the song shiftpeds length" do
      expected_time = @playlist.start_time + @playlist.playlist_items.first.song.length
      @playlist.start_time.should_not eq expected_time
      CheckTimeAndShift.tick_on_playlist @playlist.id
      @playlist.reload
      @playlist.start_time.should eq expected_time
    end

    it "should report the time as the difference between the start time (less the previous track as it also pops it off) and the current time " do
      difference = Time.now - @playlist.start_time - @playlist.playlist_items.first.song.length
      response = CheckTimeAndShift.tick_on_playlist @playlist.id
      response.should eq difference
    end
  end
end

#|Start_time|---------------------------------------|Start_time + song.length|
#|Start_time|------------|Current_time|-------------|Start_time + song.length|
#|Start_time|---------------------------------------|Start_time + song.length|------|Current_time|---------|Start_time + song2.length|
#|Start_time = Start_time + song.length|------|Current_time|---------|Start_time + song2.length|
