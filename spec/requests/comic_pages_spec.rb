require 'spec_helper'

describe "ComicPages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { valid_signin user }

  describe "comic creation" do
    before { visit new_comic_path }

    describe "with invalid information" do
      it "should not create a comic" do
        expect { click_button "Create" }.should_not change(Comic, :count)
      end

      describe "return user to new comic page" do
        before { click_button "Create" }
        it { should have_selector("title", text: "New Comic") }
      end
    end

    describe "with valid information" do
      before do
        fill_in 'Name', with: "test comic1"
        fill_in 'Description', with: "test description"
      end

      it "should create a comic" do
        expect { click_button "Create" }.should change(Comic, :count).by(1)
      end
    end
  end
end
