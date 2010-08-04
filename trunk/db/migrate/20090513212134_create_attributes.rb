class CreateAttributes < ActiveRecord::Migration
  def self.up
     create_table "attributes" do |t|
      t.column :name,   :string, :null => false
      t.column :attribute_type,   :string, :null => false
      t.timestamps
   end
  end

  def self.down
    drop_table :attributes
  end
end
