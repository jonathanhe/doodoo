require 'spec_helper'

describe UsersController do

  # Jonathan: it is important to render views here.
  # Otherwise some tests just wouldn't pass for strange reasons
  render_views

  describe "GET 'new'" do
    it "returns http success" do
      get :new
      response.should be_success
    end

    it "should have the right title" do
      get :new
      response.should have_selector('title', :content => 'Sign up')
    end

    it "should have a 'First name' field" do
      get :new
      response.should have_selector('input',
                                    :name => 'user[first_name]',
                                    :type => 'text')
      response.should have_selector("input[name='user[first_name]'][type='text']")
    end

    it "should have a 'Last name' field" do
      get :new
      response.should have_selector('input',
                                    :name => 'user[last_name]',
                                    :type => 'text')
    end

    it "should have an 'Email' field" do
      get :new
      response.should have_selector('input',
                                    :name => 'user[email]',
                                    :type => 'text')
    end

    it "should have a 'Password' field" do
      get :new
      response.should have_selector('input',
                                    :name => 'user[password]',
                                    :type => 'password')
    end

    it "should have a 'Confirmation' field" do
      get :new
      response.should have_selector('input',
                                    :name => 'user[password_confirmation]',
                                    :type => 'password')
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

      it "should have a welcome message" do
        post :create, :user => @attr
        flash[:success].should =~ /welcome/i
      end

      it "should also sign the user in" do
        post :create, :user => @attr
        controller.should be_signed_in
      end
    end
  end

  describe "PUT 'update'" do

    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end

    describe "failure case" do

      before(:each) do
        @attr = { :first_name => '', :last_name => '',
                  :email => '',      :password => '',
                  :password_confirmation => ''}
      end

      it "should render an edit page again" do
        put :update, :id => @user, :user => @attr
        response.should render_template('edit')
      end

      it "should have the right title" do
        put :update, :id => @user, :user => @attr
        response.should have_selector('title',
                                      :content => 'Edit')
      end

      it "should have a flash.now error message" do
        put :update, :id => @user, :user => @attr
        flash.now[:error].should =~ /fail/i
      end
    end

    describe "success case" do

      before(:each) do
        @attr = { :first_name => 'New_First',
                  :last_name  => 'New_Last',
                  :email      => @user.email,
                  :password   => 'foobar',
                  :password_confirmation => 'foobar'
                }
      end

      it "should change the user's attribute" do
        put :update, :id => @user, :user => @attr
        @user.reload
        @user.first_name.should == @attr[:first_name]
        @user.last_name.should  == @attr[:last_name]
        @user.email.should      == @attr[:email]
        @user.password.should   == @attr[:password]
      end

      it "should redirect to the user show page" do
        put :update, :id => @user, :user => @attr
        response.should redirect_to(user_path(@user))
      end

      it "should have a flash success message" do
        put :update, :id => @user, :user => @attr
        flash[:success].should =~ /Successfully updated/i
      end
    end
  end

  describe "require authentication for edit/update pages" do

    before(:each) do
      @user = Factory(:user)
    end

    describe "for non-signed-in users" do

      it "should should deny access to 'edit' page" do
        get :edit, :id => @user
        response.should redirect_to(signin_path)
      end

      it "should deny access to 'update' page" do
        put :update, :id => @user, :user => {}
        response.should redirect_to(signin_path)
      end
    end
  end
end
