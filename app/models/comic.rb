class Comic < ActiveRecord::Base
  attr_accessible :name, :description

  belongs_to :user

  validates :name, presence: true, uniqueness: { scope: :user_id }
end
