class Answer < ActiveRecord::Base
  attr_accessible :correct, :question_id, :text

  validates :text, presence: true

  belongs_to :question

  scope :right, where('correct = ?', true)
end
