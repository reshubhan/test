class AddColumnLinkInAssetsAndGeographies < ActiveRecord::Migration
  def self.up
    add_column :assets, :link, :text
    add_column :geographies, :link, :text
  end

  def self.down
    remove_column :assets, :link
    remove_column :geographies, :link
  end
end
