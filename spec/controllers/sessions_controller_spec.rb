require 'spec_helper'

describe SessionsController do

  describe "GET 'new'" do
    it "returns http success" do
      visit signin_path
      response.should be_success
    end
  end
end
