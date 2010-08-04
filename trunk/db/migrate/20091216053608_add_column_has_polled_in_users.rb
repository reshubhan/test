class AddColumnHasPolledInUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :has_polled, :integer, :default => 0
  end

  def self.down
    remove_column :users, :has_polled
  end
end
