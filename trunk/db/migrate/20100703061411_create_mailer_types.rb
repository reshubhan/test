class CreateMailerTypes < ActiveRecord::Migration
  def self.up
    create_table :mailer_types do |t|
      t.string :name
    end
  end

  def self.down
    drop_table(:mailer_types)
  end
end
