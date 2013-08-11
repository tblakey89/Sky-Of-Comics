class AddUserToComicImages < ActiveRecord::Migration
  def change
    add_column :comic_images, :user_id, :integer
  end
end
