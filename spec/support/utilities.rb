include ApplicationHelper

def valid_signin(user)
  visit new_user_session_path
  fill_in "Username", with: user.username
  fill_in "Password", with: user.password
  click_button "Sign in"
end
