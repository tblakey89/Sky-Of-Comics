class AddUserIndexToComicImages < ActiveRecord::Migration
  def change
    add_index :comic_images, :user_id
  end
end
