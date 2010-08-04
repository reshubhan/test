class CreatePaymentNotifications < ActiveRecord::Migration
  def self.up
    create_table :payment_notifications do |t|
      t.integer :user_id
      t.string :payment_type
      t.string :ipn_details
    end
  end

  def self.down
    drop_table :payment_notifications
  end
end
