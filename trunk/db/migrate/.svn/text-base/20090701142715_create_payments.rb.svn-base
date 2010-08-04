class CreatePayments < ActiveRecord::Migration
  def self.up
    create_table "payments", :force => true do |t|
      t.column :for, :string
      t.column :amount, :string
      t.column :currency, :string
      t.column :user_id, :integer
      t.column :trans_id, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :payments
  end
end
