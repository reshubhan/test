class AlterTableQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :answer_text, :text
  end

  def self.down
    remove_column :questions, :answer_text, :text
  end
end
