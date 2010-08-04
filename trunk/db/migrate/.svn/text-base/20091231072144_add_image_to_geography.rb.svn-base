class AddImageToGeography < ActiveRecord::Migration
  def self.up
      add_column :geographies, :image_file_name,    :string
      add_column :geographies, :image_content_type, :string
      add_column :geographies, :image_file_size,    :integer
      add_column :geographies, :image_updated_at,   :datetime
    end

    def self.down
      remove_column :geographies, :image_file_name
      remove_column :geographies, :image_content_type
      remove_column :geographies, :image_file_size
      remove_column :geographies, :image_updated_at
    end
end
