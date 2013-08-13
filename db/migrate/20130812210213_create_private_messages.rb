class CreatePrivateMessages < ActiveRecord::Migration
  def change
    create_table :private_messages do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.boolean :read
      t.string :title
      t.text :content
      t.timestamps
    end

    add_index :private_messages, [:sender_id, :recipient_id]
    add_index :private_messages, :sender_id
    add_index :private_messages, :recipient_id
  end

end
