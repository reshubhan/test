class ChangeDataTypeOfIpnDetailsInPaymentNotification < ActiveRecord::Migration
  def self.up
    remove_column(:payment_notifications,:ipn_details)
    add_column :payment_notifications,:ipn_details,:text
  end

  def self.down
    remove_column(:payment_notifications,:ipn_details)
    add_column :payment_notifications,:ipn_details,:string
  end
end
