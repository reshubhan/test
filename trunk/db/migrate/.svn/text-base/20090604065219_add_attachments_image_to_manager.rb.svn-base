class AddAttachmentsImageToManager < ActiveRecord::Migration
  def self.up
    add_column :managers, :image, :string
    add_column :managers, :image_file_name, :string
    add_column :managers, :image_content_type, :string
    add_column :managers, :image_file_size, :integer
    add_column :managers, :image_updated_at, :datetime
  end

  def self.down
    remove_column :managers, :image
    remove_column :managers, :image_file_name
    remove_column :managers, :image_content_type
    remove_column :managers, :image_file_size
    remove_column :managers, :image_updated_at
  end
end
