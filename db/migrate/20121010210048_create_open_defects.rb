class CreateOpenDefects < ActiveRecord::Migration
  def change
    create_table :open_defects do |t|
      t.primary_key :id
      t.date :week_ending
      t.integer :critical
      t.integer :high
      t.integer :medium
      t.integer :low

      t.belongs_to :project

      t.timestamps
    end
  end
end
