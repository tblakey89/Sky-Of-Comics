class Activity < ActiveRecord::Base
  attr_accessible :action, :trackable

  belongs_to :user
  belongs_to :trackable, polymorphic: true
end
