class RenameOptionIdsToOptionIdInAnswers < ActiveRecord::Migration
  def self.up
    rename_column(:answers, :option_ids, :option_id)
  end

  def self.down
    rename_column(:answers, :option_id, :option_ids)
  end
end
