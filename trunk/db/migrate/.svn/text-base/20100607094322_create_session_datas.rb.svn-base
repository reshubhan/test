class CreateSessionDatas < ActiveRecord::Migration
  def self.up
    create_table :session_datas do |t|
      t.text :data
      t.string :token

      t.timestamps
    end
  end

  def self.down
    drop_table :session_datas
  end
end
