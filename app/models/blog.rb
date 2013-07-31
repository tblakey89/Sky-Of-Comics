class Blog < ActiveRecord::Base
  attr_accessible :title, :content

  has_many :comments, as: :commentable

  belongs_to :user

  validates :title, presence: true, uniqueness: { scope: :user_id }
  validates :content, presence: true
end
