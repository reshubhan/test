class PollValueInUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :poll_value, :integer, :default => 0
  end

  def self.down
    remove_column :users, :poll_value
  end
end
