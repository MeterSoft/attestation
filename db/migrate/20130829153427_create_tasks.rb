class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :type
      t.boolean :shared
      t.integer :admin_id

      t.timestamps
    end
  end
end
