class CreateProgresses < ActiveRecord::Migration
  def change
    create_table :progresses do |t|
      t.integer :user_id
      t.integer :task_id
      t.integer :question_id
      t.integer :result_id

      t.timestamps
    end
  end
end
