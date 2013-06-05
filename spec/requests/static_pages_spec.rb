require 'spec_helper'

describe "StaticPages" do
  subject { page }

  describe "Home Page" do
    before { visit root_path }
    it { should have_selector('title', text: 'Sky of Comics') }
    it { should have_selector('h1', text: 'Sky of Comics') }
    it { should_not have_selector('title', text: 'Home') }
  end

  describe "Help Page" do
    before { visit help_path }
    it { should have_selector('title', text: 'Sky of Comics | Help') }
  end

  describe "About Page" do
    before { visit about_path }
    it { should have_selector('title', text: 'Sky of Comics | About') }
  end
end
