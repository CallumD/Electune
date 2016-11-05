require 'spec_helper'

describe 'users/edit', type: :view do
  before(:each) do
    @user = assign(:user, User.new(email: 'MyString'))
  end

  it 'renders the edit user form' do
    render
    assert_select 'form', action: users_path(@user), method: 'post' do
      assert_select 'input#user_email', name: 'user[email]'
    end
  end
end
