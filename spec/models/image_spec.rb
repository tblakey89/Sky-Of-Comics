require 'spec_helper'

describe Image do
  let(:user) { FactoryGirl.create(:user) }
  before do
    @image = user.images.build(name: "Test Images", description: "test description")
    @image.location = Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'images', 'test.jpg'))
  end

  subject { @image }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:location) }
  it { should respond_to(:user) }
  it { should respond_to(:comments) }
  it { should be_valid }

  describe "when name is not present" do
    before { @image.name = "" }
    it { should_not be_valid }
  end

  describe "when image name is not unique" do
    before do
      image2 = @image.dup
      image2.save
    end
    it { should_not be_valid }
  end

  describe "when image string is not unique" do
    before do
      image2 = @image.dup
      image2.save
    end
    it { should_not be_valid }
  end
end
