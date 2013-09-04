class Task < ActiveRecord::Base
  attr_accessible :name, :shared, :admin_id, :questions_attributes

  has_many :questions
  has_many :results
  belongs_to :admin
  has_many :progresses

  validates :name, :questions, presence: true

  accepts_nested_attributes_for :questions, allow_destroy: true

  scope :shared, lambda { where('shared = ?', true) }

  def next_question(user_id)
  	(questions - progresses.where(user_id: user_id).map(&:question)).first
  end
end
