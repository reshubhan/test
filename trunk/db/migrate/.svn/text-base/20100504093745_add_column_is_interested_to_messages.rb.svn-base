class AddColumnIsInterestedToMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :is_interested,:boolean,:default=>false
  end

  def self.down
    remove_column(:messages, :is_interested)
  end
end
