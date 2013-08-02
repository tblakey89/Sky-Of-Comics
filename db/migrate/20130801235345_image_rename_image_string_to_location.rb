class ImageRenameImageStringToLocation < ActiveRecord::Migration
  def up
    rename_column :images, :image, :location
  end

  def down
  end
end
