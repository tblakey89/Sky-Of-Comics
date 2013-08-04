class Image < ActiveRecord::Base
  attr_accessible :name, :description, :location, :remote_location_url

  has_many :comments, as: :commentable

  belongs_to :user

  mount_uploader :location, ImageUploader

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :location, presence: true, uniqueness: { scope: :user_id }
end
