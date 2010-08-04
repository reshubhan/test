class UpdateColumnDescriptionSecondaries < ActiveRecord::Migration
  def self.up
    remove_column :secondaries, :description
  end

  def self.down
    add_column :secondaries, :description, :text, :null => false
  end
end
