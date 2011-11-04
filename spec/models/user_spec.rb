require 'spec_helper'

describe User do

  before(:each) do
    @attr = { :first_name => 'Example',
              :last_name  => 'User',
              :email      => 'jon@example.com',
              :password   => 'foobar',
              :password_confirmation => 'foobar'
            }
  end

  describe "test the presence of each attribute" do
    it "should create a new instance given validate attributes" do
      User.create!(@attr)
    end

    it "should require a first_name" do
      no_first_name = User.new(@attr.merge(:first_name => ''))
      no_first_name.should_not be_valid
    end

    it "should require a last_name" do
      no_last_name = User.new(@attr.merge(:last_name => ''))
      no_last_name.should_not be_valid
    end

    it "should require an email address" do
      no_email_user = User.new(@attr.merge(:email => ''))
      no_email_user.should_not be_valid
    end

    it "should reject first_names that are too long" do
      long_first_name = 'a' * 51
      long_name_user =
        User.new(@attr.merge(:first_name => long_first_name))
      long_name_user.should_not be_valid
    end

    it "should reject last_names that are too long" do
      long_last_name = 'a' * 51
      long_name_user =
        User.new(@attr.merge(:last_name => long_last_name))
      long_name_user.should_not be_valid
    end

    it "should accept valid email addresses" do
      addresses = %w[user@foo.com
                     THE_USER@foo.bar.org
                     first.last@foo.cn]
      addresses.each do |email|
        valid_email_user = User.new(@attr.merge(:email => email))
        valid_email_user.should be_valid
      end
    end

    it "should reject invalid email addresses" do
      addresses = %w[user@foo,com
                     user_at_foo.org
                     user@example.
                     @foo.org]
      addresses.each do |email|
        invalid_email_user = User.new(@attr.merge(:email => email))
        invalid_email_user.should_not be_valid
      end
    end

    it "should reject emails identical up to cases" do
      upcased_email = @attr[:email].upcase
      User.create!(@attr.merge(:email => upcased_email))
      dup_email_user = User.new(@attr)
      dup_email_user.should_not be_valid
    end
  end

  describe "password validations" do

    it "should require a password" do
      User.new(@attr.merge(:password => '',
                           :password_confirmation => '')).
        should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@attr.merge(:password_confirmation => 'invalid')).
        should_not be_valid
    end

    it "should reject short password" do
      short_pass = 'a' * 5
      hash = @attr.merge(:password => short_pass,
                         :password_confirmation => short_pass)
      User.new(hash).should_not be_valid
    end

    it "should reject long password" do
      long_pass = 'a' * 41
      hash = @attr.merge(:password => long_pass,
                         :password_confirmation => long_pass)
      User.new(hash).should_not be_valid
    end
  end

  describe "password encryption" do

    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted_password attribute" do
      @user.encrypted_password.should_not be_blank
    end

    it "should be true if the passwords match" do
      @user.has_password?(@attr[:password]).should be_true
    end

    it "should be false if the passwords don't match" do
      @user.has_password?('invalid').should be_false
    end

    describe "authenticate method" do

      it "should return nil on email and password mismatch" do
        wrong_password_user = User.authenticate(@attr[:email],
                                                'wrong_pass')
        wrong_password_user.should be_nil
      end

      it "should return nil for an email address with no user" do
        nonexist_user = User.authenticate('invalid@example.com',
                                          @attr[:password])
        nonexist_user.should be_nil
      end

      it "should return the user when email and password match" do
        valid_user = User.authenticate(@attr[:email],
                                       @attr[:password])
        valid_user.should == @user
      end
    end
  end
end
# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  first_name         :string(255)
#  last_name          :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#

