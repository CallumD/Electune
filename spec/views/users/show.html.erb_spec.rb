require 'spec_helper'

describe 'users/show', type: :view do
  before(:each) do
    @user = assign(:user, create(:user, email: 'Email@gmail.com'))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Email/)
  end
end
