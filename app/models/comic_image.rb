class ComicImage < ActiveRecord::Base
  attr_accessible :image, :page_number

  belongs_to :comic

  mount_uploader :image, ComicImageUploader

  validates :image, presence: true
  validates :page_number, presence: true, uniqueness: { comic_id: true }
end
