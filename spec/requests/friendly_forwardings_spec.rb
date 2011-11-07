require 'spec_helper'

describe "FriendlyForwardings" do

  it "should forward to the requested page after signing in" do
    user = Factory(:user)
    visit edit_user_path(user)
    # We will be redirected to the signin page since
    # we haven't signed in
    fill_in :email,    :with => user.email
    fill_in :password, :with => user.password
    click_button
    # now test if we are redirected to the edit_user_path
    # Note: we can't verify if the page was redirected since
    #       the integration test follows redirects
    response.should render_template('users/edit')
  end
end
