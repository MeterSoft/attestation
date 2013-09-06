class WriteAnswer < ActiveRecord::Base
  attr_accessible :question_id, :result_id, :task_id, :text, :user_id

  belongs_to :result
  belongs_to :question
end
