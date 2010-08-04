class CreateAssetAttributes < ActiveRecord::Migration
  def self.up
    create_table :asset_attributes do |t|
      t.integer :asset_id
      t.integer :attribute_id
      t.string :attribute_type
    end
  end

  def self.down
    drop_table :asset_attributes
  end
end
