require 'spec_helper'

describe "LayoutLinks" do

  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector('title', :content => 'Home')
  end

  it "should have a Contact us page at '/contact'" do
    get '/contact'
    response.should have_selector('title', :content => 'Contact us')
  end

  it "should have an About us page at '/about'" do
    get '/about'
    response.should have_selector('title', :content => 'About us')
  end

  it "should have a Help page at '/help'" do
    get '/help'
    response.should have_selector('title', :content => 'Help')
  end

  it "should have the links on the Home page" do
    visit root_path
    click_link 'Contact'
    response.should have_selector('title', :content => 'Contact us')
    click_link 'About'
    response.should have_selector('title', :content => 'About us')
    click_link 'Help'
    response.should have_selector('title', :content => 'Help')
    click_link 'Home'
    response.should have_selector('title', :content => 'Home')
    click_link 'Sign up now!'
    response.should have_selector('title', :content => 'Sign up')
  end
end
