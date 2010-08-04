class AddSenderReadAndReceiverReadToMessages < ActiveRecord::Migration
  def self.up
    rename_column(:messages,:read_status,:sender_read)
    add_column :messages, :receiver_read, :boolean
  end

  def self.down
    rename_column(:messages,:sender_read,:read_status)
    remove_column(:messages, :receiver_read)
  end
end
