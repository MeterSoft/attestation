class Progress < ActiveRecord::Base
  attr_accessible :question_id, :task_id, :user_id, :result_id

  belongs_to :task
  belongs_to :question
  belongs_to :result
end
