require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.build(:user) }

  it 'validates that the user has an email' do
    user = FactoryGirl.build(:user, email: nil)
    expect(user).not_to be_valid
  end

  it 'ensures that the users email is unique' do
    user.save
    duplicate = FactoryGirl.build(:user, email: user.email)
    expect(duplicate).not_to be_valid
  end

  it 'saves the email in lowercase' do
    test_email = 'UPPERandlower@email.com'
    user = FactoryGirl.create(:user, email: test_email)
    expect(user.email).to eq test_email.downcase
  end

  it 'has a password of at least 6 characters' do
    user = FactoryGirl.build(:user, password: 'F1ve!', password_confirmation: 'F1ve!')
    expect(user).not_to be_valid
  end

  it 'validates the presence of the password confirmation' do
    user = FactoryGirl.build(:user, password_confirmation: nil)
    expect(user).not_to be_valid
  end

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
end
