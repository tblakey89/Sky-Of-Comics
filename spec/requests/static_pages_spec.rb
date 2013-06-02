require 'spec_helper'

describe "StaticPages" do
  describe "Home Page" do
    it "should have the h1 'Sky of Comics'" do
      visit '/static_pages/home'
      page.should have_selector('title', text: 'Sky of Comics')
      page.should have_selector('h1', text: 'Sky of Comics')
    end
    it "should not have a custom title" do
      visit '/static_pages/home'
      page.should_not have_selector('title', text: 'Home')
    end
  end

  describe "Help Page" do
    it "should have the content 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('title', text: 'Sky of Comics | Help')
    end
  end

  describe "About Page" do
    it "should have content 'About'" do
      visit '/static_pages/about'
      page.should have_selector('title', text: 'Sky of Comics | About')
    end
  end
end
