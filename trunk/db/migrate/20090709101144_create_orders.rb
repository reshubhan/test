class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :user_id
      t.integer :plan_id
      t.integer :amount
      t.string :card_type
      t.datetime :card_expires_on

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
