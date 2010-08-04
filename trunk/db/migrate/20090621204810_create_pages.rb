class CreatePages < ActiveRecord::Migration
  def self.up
    create_table "pages", :force => true do |t|
      t.column :name, :string, :null => false
      t.column :title, :string
      t.column :content, :text
      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
