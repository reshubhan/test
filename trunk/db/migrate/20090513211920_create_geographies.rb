class CreateGeographies < ActiveRecord::Migration
  def self.up
    create_table "geographies" do |table|
      table.column :name,  :string, :null => false
      table.timestamps
    end
  end

  def self.down
    drop_table :geographies
  end
end
