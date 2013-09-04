class Question < ActiveRecord::Base
  attr_accessible :task_id, :text, :answers_attributes

  has_many :answers
  belongs_to :task
  has_one :progress

  validates :text, :answers, presence: true

  accepts_nested_attributes_for :answers, allow_destroy: true

  def right_answers?(a = [])
  	answers.right.map{ |a| a.id.to_s } - a == [] ? true : false
  end
end
