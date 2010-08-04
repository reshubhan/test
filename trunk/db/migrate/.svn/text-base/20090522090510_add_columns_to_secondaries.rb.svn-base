class AddColumnsToSecondaries < ActiveRecord::Migration
  def self.up
    add_column :secondaries, :bite_size, :integer
    add_column :secondaries, :notes, :string
  end

  def self.down
    remove_column :secondaries, :bite_size
    remove_column :secondaries, :notes
  end
end
