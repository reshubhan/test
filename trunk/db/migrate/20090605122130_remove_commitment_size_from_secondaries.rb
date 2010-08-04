class RemoveCommitmentSizeFromSecondaries < ActiveRecord::Migration
  def self.up
    remove_column("secondaries", "commitment_size")
  end

  def self.down
    add_column :secondaries, :commitment_size, :integer
  end
end
