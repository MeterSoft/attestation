class CreateWriteAnswers < ActiveRecord::Migration
  def change
    create_table :write_answers do |t|
      t.integer :result_id
      t.integer :task_id
      t.integer :user_id
      t.integer :question_id
      t.text :text

      t.timestamps
    end
  end
end
