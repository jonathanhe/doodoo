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

    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end

    it "should have the right title" do
      get :show, :id => @user
      response.should have_selector('title',
                                    :content => @user.first_name)
    end

    it "should include the user's first_name" do
      get :show, :id => @user
      response.should have_selector('h1',
                                    :content => @user.first_name)
    end
  end

  describe "POST 'create'" do

    describe "failure cases" do

      before(:each) do
        @attr = { :first_name => "", :last_name => "",
                  :email => "",
                  :password => "",
                  :password_confirmation => "" }
      end

      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end

      it "should be redirected back to sign up page" do
        post :create, :user => @attr
        response.should have_selector('title',
                                      :content => "Sign up")
      end

      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template(new_user_path)
        #response.should render_template('new')
      end
    end

    describe "success cases" do

      before(:each) do
        @attr = { :first_name => "Example",
                  :last_name  => "User",
                  :email      => "user@example.com",
                  :password   => "foobar",
                  :password_confirmation => "foobar"
                }
      end

      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end

      it "should redirect to the user show page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end
    end
  end
end
