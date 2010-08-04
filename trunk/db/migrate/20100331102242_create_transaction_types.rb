class CreateTransactionTypes < ActiveRecord::Migration
  def self.up
    create_table :transaction_types do |t|
      t.string :transaction_type
      t.integer :asset_id

      t.timestamps
    end
  end

  def self.down
    drop_table :transaction_types
  end
end
