class PrivateMessage < ActiveRecord::Base
  attr_accessible :title, :content, :recipient_id, :read

  belongs_to :recipient, class_name: "User"
  belongs_to :sender, class_name: "User"

  validates :content, presence: true
  validates :recipient_id, presence: true
end
