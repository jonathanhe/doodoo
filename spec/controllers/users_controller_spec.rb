require 'spec_helper'

describe UsersController do

  # Jonathan: it is important to render views here.
  # Otherwise some tests just wouldn't pass for strange reasons
  render_views

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end

    it "should have the right title" do
      get 'new'
      response.should have_selector('title', :content => 'Sign up')
    end
  end

  describe "GET 'show'" do

    before(:each) do
      @user = Factory(:user)
    end

    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end

    it "should have the right title" do
      get :show, :id => @user
      response.should have_selector('title',
                                    :content => @user.first_name)
    end
  end
end
