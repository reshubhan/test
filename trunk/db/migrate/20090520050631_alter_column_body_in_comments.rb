class AlterColumnBodyInComments < ActiveRecord::Migration
  def self.up
    change_column  :comments, :body , :string , :limit =>400
  end

  def self.down
    change_column :comments, :body , :string
  end
end
