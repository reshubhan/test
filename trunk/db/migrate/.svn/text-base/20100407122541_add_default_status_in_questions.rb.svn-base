class AddDefaultStatusInQuestions < ActiveRecord::Migration
  def self.up
    remove_column(:questions, :status)
    add_column :questions ,:status,:boolean,:default=>true
  end

  def self.down
    remove_column(:questions, :status)
    add_column :questions ,:status,:boolean
  end
end
