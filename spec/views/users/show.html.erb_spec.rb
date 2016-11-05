require 'spec_helper'

describe 'users/show' do
  before(:each) do
    @user = assign(:user, stub_model(User,
                                     email: 'Email'))
  end

  it 'renders attributes in <p>' do
    render
    rendered.should match(/Email/)
  end
end
