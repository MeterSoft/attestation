class Result < ActiveRecord::Base
  attr_accessible :mark, :mark_type, :task_id, :user_id

  MARK_TYPE = []

  belongs_to :user
  belongs_to :admin
  has_many :progresses, dependent: :destroy

  scope :by_task_id, lambda { |id| where('task_id = ?', id) }

  def up_mark
  	update_attributes(mark: mark.to_i + 1)
  end
end
