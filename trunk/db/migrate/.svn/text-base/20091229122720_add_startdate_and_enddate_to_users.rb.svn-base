class AddStartdateAndEnddateToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :start_date, :date
    add_column :users, :end_date, :date
  end

  def self.down
    remove_column :users, :start_date
    remove_column :users, :end_date
  end
end
