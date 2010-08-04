class AddChangesToMessages < ActiveRecord::Migration
  def self.up
    rename_column(:messages, :user_id, :sender_id)
    add_column :messages, :receiver_id, :integer, :default => false
    add_column :messages, :post_id, :integer, :default => false
    add_column :messages, :post_type, :string, :default => false
    add_column :messages, :read_status, :boolean, :default => false
    add_column :messages, :response, :boolean, :default => false
    add_column :messages, :message_key, :string, :default => false
  end

  def self.down
    rename_column(:messages, :sender_id, :user_id)
    remove_column :messages, :receiver_id
    remove_column :messages, :post_id
    remove_column :messages, :post_type
    remove_column :messages, :read_status
    remove_column :messages, :response
    remove_column :messages, :message_key
  end
end
