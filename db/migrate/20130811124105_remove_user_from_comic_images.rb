class RemoveUserFromComicImages < ActiveRecord::Migration
  def up
    remove_column :comic_images, :user_id
  end

  def down
  end
end
