class AlterColumnBodyInCommentsTo2000 < ActiveRecord::Migration
  def self.up
    change_column  :comments, :body , :string , :limit =>2000
  end

  def self.down
    change_column :comments, :body , :string
  end
end
