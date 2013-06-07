include ApplicationHelper

def valid_signin(user)
  fill_in "Username", with: user.username
  fill_in "Password", with: user.password
  click_button "Sign in"
end
