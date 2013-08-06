class Blog < ActiveRecord::Base
  attr_accessible :name, :content

  has_many :comments, as: :commentable

  belongs_to :user

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validates :content, presence: true
end
