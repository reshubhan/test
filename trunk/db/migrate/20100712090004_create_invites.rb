class CreateInvites < ActiveRecord::Migration
  def self.up
    create_table :invites do |t|
      t.integer :user_id
      t.string :receipient_email_id
      t.string :type
      t.boolean :status ,:default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :invites
  end
end
