class AddUniqueNameToEachUser < ActiveRecord::Migration
  def change
    add_index :comics, [:user_id, :name], uniqueness: true
  end
end
