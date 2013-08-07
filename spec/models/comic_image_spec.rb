require 'spec_helper'

describe ComicImage do
  let(:comic) { FactoryGirl.create(:comic) }
  before do
    @comic_image = comic.comic_images.build(page_number: "1")
    @comic_image.image = Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'test.jpg'))
  end

  subject { @comic_image }

  it { should respond_to(:page_number) }
  it { should respond_to(:image) }
  it { should respond_to(:comic) }
  it { should be_valid }

  describe "when page_number is not present" do
    before { @comic_image.page_number = nil }
    it { should_not be_valid }
  end

  describe "when comic has two page with same page number" do
    before do
      other_image = @comic_image.dup
      other_image.save
    end
    it { should_not be_valid }
  end
end
