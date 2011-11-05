require 'spec_helper'

describe "Users" do

  describe "sign up" do

    describe "failure" do

      it "should not create a new user" do
        lambda do
          visit signup_path
          fill_in "First name",   :with => ''
          fill_in "Last name",    :with => ''
          fill_in "Email",        :with => ''
          fill_in "Password",     :with => ''
          fill_in "Confirmation", :with => ''
          click_button
          response.should have_selector("div#error_explanation")
          response.should render_template(new_user_path)
          #response.should render_template('users/new')
        end.should_not change(User, :count)
      end
    end

    describe "success" do

      it "should create a new user" do
        lambda do
          visit signup_path
          fill_in "First name",   :with => "Jonathan"
          fill_in "Last name",    :with => "He"
          fill_in "Email",        :with => "jon@example.com"
          fill_in "Password",     :with => "foobar"
          fill_in "Confirmation", :with => "foobar"
          click_button
          response.should have_selector('title',
                                        :content => 'Welcome')
          response.should have_selector('div.flash.success',
                                        :content => 'Welcome')
          response.should render_template('users/show')
        end.should change(User, :count).by(1)
      end
    end
  end

  describe "sign in and sign out" do

    before(:each) do
    end

    describe "failure case" do

      it "should not sign a user in given invalid email / password" do
        visit signin_path
        fill_in :email,    :with => ''
        fill_in :password, :with => ''
        click_button
        response.should have_selector('div.flash.error',
                                      :content => 'invalid')
        controller.should_not be_signed_in
      end
    end

    describe "success case" do

      it "should sign a valid user in and out" do
        integration_sign_in(Factory(:user))
        response.should have_selector('div.flash.success',
                                      :content => 'Welcome')
        controller.should be_signed_in
        click_link "Sign out"
        controller.should_not be_signed_in
      end
    end
  end
end
