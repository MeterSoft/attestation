class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :type
      t.boolean :shared
      t.integer :admin_id
      t.boolean :iteration, default: false

      t.integer :max_mark
      t.integer :time
      t.string :task_type

      t.timestamps
    end
  end
end
