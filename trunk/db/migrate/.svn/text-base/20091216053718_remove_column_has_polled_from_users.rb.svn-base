class RemoveColumnHasPolledFromUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :has_polled
  end
  
  def self.down
    add_column :users, :has_polled, :integer, :default => 0
  end
end
