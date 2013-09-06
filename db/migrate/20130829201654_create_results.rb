class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :user_id
      t.integer :task_id
      t.integer :mark, default: 0
      t.boolean :checked, default: false
      t.boolean :finished, default: false

      t.timestamps
    end
  end
end
