class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.primary_key :id
      t.string :name
      t.string :tfs_path
      t.integer :team_id

      t.timestamps
    end
  end
end
