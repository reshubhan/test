class CreateCommentRatings < ActiveRecord::Migration
  def self.up
    create_table "comment_ratings", :force => true do |t|
      t.column :comment_id,                 :integer, :null => false
      t.column :user_id,                    :integer, :null => false
      t.column :rate,                       :string, :null => false
    end
    remove_column("comments", "ups_count")
    remove_column("comments", "downs_count")
  end

  def self.down
    drop_table :comment_ratings
    add_column :comments, :ups_count, :integer
    add_column :comments, :downs_count, :integer
  end
end
