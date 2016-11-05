require 'spec_helper'

describe 'users/new', type: :view do
  before(:each) do
    assign(:user, create(:user, email: 'MyString@gmail.com'))
  end

  it 'renders new user form' do
    render
    assert_select 'form', action: users_path, method: 'post' do
      assert_select 'input#user_email', name: 'user[email]'
    end
  end
end
