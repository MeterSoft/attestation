class Result < ActiveRecord::Base
  attr_accessible :mark, :task_id, :user_id, :finished

  belongs_to :task
  has_many :progresses, dependent: :destroy
  has_many :write_answers, dependent: :destroy

  scope :by_task_id, lambda { |id| where('task_id = ?', id) }

  def up_mark(rate)
  	update_attributes(mark: mark + rate)
  end

  def time_valid?
    created_at + task.time * 60 < Time.now 
  end

  def finished?
    finished
  end
end
