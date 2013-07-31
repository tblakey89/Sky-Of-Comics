class Comment < ActiveRecord::Base
  attr_accessible :content, :user_id

  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :content, presence: true
  validates :user, presence: true
end
