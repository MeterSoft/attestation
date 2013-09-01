class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :user_id
      t.integer :task_id
      t.string :mark
      t.string :mark_type
      t.boolean :checked, default: false

      t.timestamps
    end
  end
end
