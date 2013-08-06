class ChangeBlogTitleToName < ActiveRecord::Migration
  def up
    rename_column :blogs, :title, :name
  end

  def down
  end
end
