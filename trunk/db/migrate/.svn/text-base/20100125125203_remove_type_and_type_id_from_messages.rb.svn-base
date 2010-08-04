class RemoveTypeAndTypeIdFromMessages < ActiveRecord::Migration
  def self.up
    rename_column(:messages, :response, :is_not_interested)
    remove_column(:messages, :type)
    remove_column(:messages, :type_id)
    add_column :messages,:status,:boolean
  end

  def self.down
    rename_column(:messages, :is_not_interested, :response)
    add_column :messages, :type, :string
    add_column :messages, :type_id, :integer
    remove_column(:messages, :status)
  end
end
