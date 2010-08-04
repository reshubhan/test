class DropPayments < ActiveRecord::Migration
  
  def self.up
    drop_table :payments
  end
  
  def self.down
    create_table "payments", :force => true do |t|
      t.column :for, :string
      t.column :amount, :string
      t.column :currency, :string
      t.column :user_id, :integer
      t.column :trans_id, :string
      t.timestamps
    end
  end

end
