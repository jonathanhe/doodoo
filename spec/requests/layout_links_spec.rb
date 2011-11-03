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
end
