class AddUniquenessForImageStringForUser < ActiveRecord::Migration
  def up
    add_index :images, [:user_id, :image], uniqueness: true
  end

  def down
  end
end
