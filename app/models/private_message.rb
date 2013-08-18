class PrivateMessage < ActiveRecord::Base
  after_create :add_last_reply_to_original_message

  attr_accessible :title, :content, :recipient_id, :read, :reply_id, :last_reply

  has_many :replies, foreign_key: "reply_id", class_name: "PrivateMessage"

  belongs_to :recipient, class_name: "User"
  belongs_to :sender, class_name: "User"
  belongs_to :reply, class_name: "PrivateMessage"

  validates :content, presence: true
  validates :recipient_id, presence: true

  def new_reply
    reply = self.reply_id ? self.reply_id : self.id
    self.recipient.sent_messages.new(reply_id: reply, recipient_id: self.sender.id)
  end

private
  def add_last_reply_to_original_message
    if self.reply_id
      message = PrivateMessage.find(self.reply_id)
      message.last_reply = DateTime.now
      message.save
    end
  end
end
