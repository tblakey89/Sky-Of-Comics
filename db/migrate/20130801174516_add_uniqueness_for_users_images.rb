class AddUniquenessForUsersImages < ActiveRecord::Migration
  def up
    add_index :images, [:user_id, :name], uniquenss: true
  end

  def down
  end
end
