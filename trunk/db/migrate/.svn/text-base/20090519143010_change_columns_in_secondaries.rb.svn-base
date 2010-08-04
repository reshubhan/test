class ChangeColumnsInSecondaries < ActiveRecord::Migration
  def self.up
    remove_column :secondaries, :par
    remove_column :secondaries, :discount
    add_column :secondaries, :expected_price, :string, :null => false
  end

  def self.down
    add_column :secondaries, :par, :integer
    add_column :secondaries, :discount, :integer
    remove_column :secondaries, :expected_price
  end
end
