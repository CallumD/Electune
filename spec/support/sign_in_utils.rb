include ApplicationHelper

def valid_signin(user)
  fill_in 'Email',    with: user.email
  fill_in 'Password', with: user.password
  click_button 'Sign in'
end

def sign_in(user)
  session[:user_id] = user.id
end

def sign_in_capy(user)
  visit signin_path
  fill_in 'Email',    with: user.email
  fill_in 'Password', with: user.password
  click_button 'Sign in'
end
