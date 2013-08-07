class CreateComicImages < ActiveRecord::Migration
  def change
    create_table :comic_images do |t|
      t.integer :page_number
      t.integer :comic_id
      t.string :image
      t.timestamps
    end

    add_index :comic_images, :comic_id
  end
end
