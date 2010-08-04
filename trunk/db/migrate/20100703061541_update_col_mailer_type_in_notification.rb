class UpdateColMailerTypeInNotification < ActiveRecord::Migration
  def self.up
    rename_column(:notifications, :mailer_type, :mailer_type_id)
  end

  def self.down
    rename_column(:notifications, :mailer_type_id, :mailer_type)
  end
end
