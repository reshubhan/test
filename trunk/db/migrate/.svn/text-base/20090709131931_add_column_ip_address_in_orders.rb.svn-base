class AddColumnIpAddressInOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :ip_address, :string
    add_column :orders, :first_name, :string
    add_column :orders, :last_name, :string
  end

  def self.down
    remove_column(:orders, :ip_address)
    remove_column(:orders, :first_name)
    remove_column(:orders, :last_name)
  end
end
