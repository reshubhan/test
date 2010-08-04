class AddQuestionsUsers < ActiveRecord::Migration
  def self.up
    create_table :questions_users do |t|
      t.integer :question_id
      t.integer :user_id
    end

    add_index :questions_users, :question_id
    add_index :questions_users, :user_id
  end

  def self.down
    drop_table :questions_users
  end
end
