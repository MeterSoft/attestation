class Result < ActiveRecord::Base
  attr_accessible :mark, :task_id, :user_id, :finished

  belongs_to :task
  belongs_to :user
  has_one :admin, through: :task
  
  has_many :progresses, dependent: :destroy
  has_many :write_answers, dependent: :destroy

  scope :by_task_id, lambda { |id| where('task_id = ?', id) }
  scope :find_by_admin_name, lambda { |search| includes(:admin).where("(CONCAT_WS(' ', lower(admins.first_name), lower(admins.last_name)) LIKE ?)
                                               OR (CONCAT_WS(' ', lower(admins.last_name), lower(admins.first_name)) LIKE ?)",
                                               "%#{search.downcase}%", "%#{search.downcase}%") }
  scope :find_by_user_name, lambda { |search| includes(:user).where("(CONCAT_WS(' ', lower(users.first_name), lower(users.last_name)) LIKE ?)
                                               OR (CONCAT_WS(' ', lower(users.last_name), lower(users.first_name)) LIKE ?)",
                                               "%#{search.downcase}%", "%#{search.downcase}%") }
  scope :find_by_task_name, lambda { |search| includes(:task).where("tasks.name LIKE ?", "%#{search.downcase}%") }
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
