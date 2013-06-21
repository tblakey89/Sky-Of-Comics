class CreateComics < ActiveRecord::Migration
  def change
    create_table :comics do |t|
      t.string :name
      t.integer :user_id
      t.text :description
      t.timestamps
    end

    add_index :comics, :user_id
  end
end
