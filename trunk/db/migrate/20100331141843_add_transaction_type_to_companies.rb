class AddTransactionTypeToCompanies < ActiveRecord::Migration
  def self.up
    add_column(:companies, :transaction_id, :integer)
  end

  def self.down
    remove_column(:companies, :transaction_id)
  end
end
