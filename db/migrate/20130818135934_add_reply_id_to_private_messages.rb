class AddReplyIdToPrivateMessages < ActiveRecord::Migration
  def change
    add_column :private_messages, :reply_id, :integer
  end
end
