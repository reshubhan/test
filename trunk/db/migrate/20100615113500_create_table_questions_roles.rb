class CreateTableQuestionsRoles < ActiveRecord::Migration
   def self.up
    create_table :questions_roles, :id => false do |t|
      t.column :question_id, :integer, :null => false
      t.column :role_id, :integer, :null => false
    end
  end

  def self.down
    drop_table :questions_roles
  end
end
