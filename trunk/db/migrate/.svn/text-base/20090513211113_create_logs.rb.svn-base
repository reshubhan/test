class CreateLogs < ActiveRecord::Migration
  def self.up
    create_table "logs", :force => true do |t|
      t.column :action, :string, :null => false
      t.column :message, :string, :null => false
      t.column :user_id, :integer, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table "logs"
  end
end
