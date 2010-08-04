class AddDefaultsToOptions < ActiveRecord::Migration
  def self.up
    add_column :options, :default_check, :boolean ,:default =>false
  end

  def self.down
    remove_column :options, :default_check
  end
end
