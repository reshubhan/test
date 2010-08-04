class AddTransactionIdToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :transaction_id, :integer
    add_column :orders, :status, :string
  end

  def self.down
    remove_column(:orders, :transaction_id)
    remove_column(:orders, :status)

  end
end
