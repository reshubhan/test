class ChangeDataTypeOfTransactionIdToString < ActiveRecord::Migration
  def self.up
    remove_column(:orders, :transaction_id)
    add_column :orders, :transaction_id, :string 
  end

  def self.down
    remove_column(:orders, :transaction_id)
    add_column :orders, :transaction_id, :int
  end
end
