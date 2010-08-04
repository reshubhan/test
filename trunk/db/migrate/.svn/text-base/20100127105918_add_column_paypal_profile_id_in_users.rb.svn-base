class AddColumnPaypalProfileIdInUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :paypal_profile_id, :string
  end

  def self.down
    remove_column(:users, :paypal_profile_id)
  end
end
