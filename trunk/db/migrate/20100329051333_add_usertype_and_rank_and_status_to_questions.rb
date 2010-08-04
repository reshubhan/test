class AddUsertypeAndRankAndStatusToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions ,:user_type,:string
    add_column :questions ,:rank,:integer
    add_column :questions ,:status,:boolean
  end

  def self.down
    remove_column(:questions, :usertype)
    remove_column(:questions, :rank)
    remove_column(:questions, :status)
  end
end
