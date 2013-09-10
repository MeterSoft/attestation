class Task < ActiveRecord::Base
  attr_accessible :name, :shared, :admin_id, :questions_attributes, :task_type, :max_mark, :time, :iteration

  include Mark

  has_many :questions
  has_many :results
  belongs_to :admin
  has_many :progresses

  validates :name, :questions, :max_mark, presence: true
  validates :max_mark, numericality: { greater_than_or_equal_to: 0 }

  accepts_nested_attributes_for :questions, allow_destroy: true

  scope :shared, lambda { where('shared = ?', true) }

  def next_question(user_id)
  	(questions - progresses.where(user_id: user_id).map(&:question)).first
  end

  def write?
    task_type == "write"
  end

  def check?
    task_type == "check"
  end

  def time?
    time
  end
end