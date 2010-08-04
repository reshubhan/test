class CreateFacebookUsers < ActiveRecord::Migration
  def self.up
    create_table :facebook_users do |t|
      t.integer :user_id
      t.string :facebook_user_id
      t.string :image_url
      t.boolean :deleted
      t.timestamps
    end
  end

  def self.down
    drop_table :facebook_users
  end
end
