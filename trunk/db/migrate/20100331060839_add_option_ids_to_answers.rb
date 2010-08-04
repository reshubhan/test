class AddOptionIdsToAnswers < ActiveRecord::Migration
  def self.up
    add_column :answers, :option_ids, :string
  end

  def self.down
    remove_column :answers, :option_ids
  end
end
