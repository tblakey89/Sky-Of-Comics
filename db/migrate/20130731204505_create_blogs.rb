class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.timestamps
    end

    add_index :blogs, [:user_id, :title], unique: true
    add_index :blogs, :user_id
  end
end
