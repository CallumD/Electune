require 'spec_helper'

describe 'users/index', type: :view do
  before(:each) do
    assign(:users, [create(:user), create(:user)])
  end

  it 'renders a list of users' do
    render
    assert_select 'tr>td', text: User.first.email, count: 1
    assert_select 'tr>td', text: User.last.email, count: 1
  end
end
