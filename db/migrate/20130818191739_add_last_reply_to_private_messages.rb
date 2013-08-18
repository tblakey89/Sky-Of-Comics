class AddLastReplyToPrivateMessages < ActiveRecord::Migration
  def change
    add_column :private_messages, :last_reply, :datetime
  end
end
