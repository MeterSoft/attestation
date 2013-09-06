class Result < ActiveRecord::Base
  attr_accessible :mark, :mark_type, :task_id, :user_id, :finished

  MARK_TYPE = ["B5", "B12", "BN"]

  belongs_to :user
  belongs_to :admin
  belongs_to :task
  has_many :progresses, dependent: :destroy
  has_many :write_answers, dependent: :destroy

  scope :by_task_id, lambda { |id| where('task_id = ?', id) }

  def up_mark(rate)
  	update_attributes(mark: mark + rate)
  end
end
