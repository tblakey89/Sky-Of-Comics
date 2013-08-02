class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :name
      t.text :description
      t.string :image
      t.integer :user_id
      t.timestamps
    end

    add_index :images, :user_id
  end
end
