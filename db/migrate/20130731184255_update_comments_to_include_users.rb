class UpdateCommentsToIncludeUsers < ActiveRecord::Migration
  def up
    add_column :comments, :user_id, :integer
    add_index :comments, [:user_id, :id]
  end

  def down
  end
end
