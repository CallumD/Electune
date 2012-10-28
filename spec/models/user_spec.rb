require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.build(:user) }
  
  it "should validate that the user has an email" do
    user = FactoryGirl.build(:user, email: nil)
    user.should_not be_valid
  end
  
  it "should ensure that the users email is unique" do
    user.save
    duplicate = FactoryGirl.build(:user)
    duplicate.should_not be_valid
  end

  it "should save the email in lowercase" do
    test_email = "UPPERandlower@email.com"
    user = FactoryGirl.create(:user, email: test_email)
    user.email.should eq test_email.downcase
  end
  
  it "should have a password of at least 6 characters" do
    user = FactoryGirl.build(:user, password: 'F1ve!', password_confirmation: 'F1ve!')
    user.should_not be_valid
  end  
  
  it "should validate the presence of the password confirmation" do
    user = FactoryGirl.build(:user, password_confirmation: nil)
    user.should_not be_valid
  end  

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
end
