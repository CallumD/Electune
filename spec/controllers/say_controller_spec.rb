require 'spec_helper'

describe SayController do

  describe "GET 'hello'" do
    it "returns http success" do
      get 'hello'
      response.should be_success
    end
  end

  describe "GET 'goodbye'" do
    it "returns http success" do
      get 'goodbye'
      response.should be_success
    end
  end

end
