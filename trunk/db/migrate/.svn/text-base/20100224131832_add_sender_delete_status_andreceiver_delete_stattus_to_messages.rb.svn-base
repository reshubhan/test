class AddSenderDeleteStatusAndreceiverDeleteStattusToMessages < ActiveRecord::Migration
  def self.up
    rename_column(:messages,:status,:sender_delete_status)
     add_column :messages, :receiver_delete_status, :boolean
  end

  def self.down
     rename_column(:messages,:sender_delete_status,:status)
     remove_column(:messages, :receiver_delete_status)
  end
end
