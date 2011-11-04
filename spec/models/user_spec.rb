require 'spec_helper'

describe User do

  before(:each) do
    @attr = { :first_name => 'Example',
              :last_name  => 'User',
              :email      => 'jon@example.com'}
  end

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
end
# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

