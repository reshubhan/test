class RemoveImageColumnFromAssetsAndGeographies < ActiveRecord::Migration
  def self.up
    remove_column :assets, :image_file_name
      remove_column :assets, :image_content_type
      remove_column :assets, :image_file_size
      remove_column :assets, :image_updated_at
      remove_column :geographies, :image_file_name
      remove_column :geographies, :image_content_type
      remove_column :geographies, :image_file_size
      remove_column :geographies, :image_updated_at
  end

  def self.down
    add_column :assets, :image_file_name,    :string
      add_column :assets, :image_content_type, :string
      add_column :assets, :image_file_size,    :integer
      add_column :assets, :image_updated_at,   :datetime
      add_column :geographies, :image_file_name,    :string
      add_column :geographies, :image_content_type, :string
      add_column :geographies, :image_file_size,    :integer
      add_column :geographies, :image_updated_at,   :datetime
  end
end
