require 'spec_helper'

describe PagesController do

  # Jonathan: it is important to render views here.
  # Otherwise some tests just wouldn't pass for strange reasons
  render_views

  before(:each) do
    @base_title = "Doodoo"
  end

  describe "GET 'home'" do
    it "returns http success" do
      get :home
      response.should be_success
    end

    it "should have the right title" do
      get :home
      response.should have_selector('title',
                                    :content => "#{@base_title} | Home")
    end
  end

  describe "GET 'contact'" do
    it "returns http success" do
      get :contact
      response.should be_success
    end

    it "should have the right title" do
      get :contact
      response.should have_selector('title',
                                    :content => "#{@base_title} | Contact us")
    end
  end

  describe "GET 'about'" do
    it "returns http success" do
      get :about
      response.should be_success
    end

    it "should have the right title" do
      get :about
      response.should have_selector('title',
                                    :content => "#{@base_title} | About us")
    end
  end

  describe "GET 'help'" do
    it "returns http success" do
      response.should be_success
    end

    it "should have the right title" do
      get :help
      response.should have_selector('title',
                                    :content => "#{@base_title} | Help")
    end
  end

end
