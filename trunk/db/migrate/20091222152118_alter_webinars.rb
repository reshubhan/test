class AlterWebinars < ActiveRecord::Migration
  def self.up
    add_column :webinars, :link, :text, :null => false
    change_column :webinars, :title, :text, :null => false
    change_column :webinars, :speaker, :text, :null => false
  end

  def self.down
    remove_column(:webinar, :link)
    change_column :webinars, :title, :string
    change_column :webinars, :speaker, :string
  end
end
