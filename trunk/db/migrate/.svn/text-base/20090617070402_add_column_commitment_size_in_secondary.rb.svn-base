class AddColumnCommitmentSizeInSecondary < ActiveRecord::Migration
  def self.up
    add_column :secondaries, :commitment_size, :string
  end

  def self.down
    remove_column("secondaries", "commitment_size")
  end
end
