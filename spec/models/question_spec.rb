require 'spec_helper'

describe Question do
	let(:question) { FactoryGirl.create(:question) }
	let(:answer) { FactoryGirl.create(:answer, correct: true) }

	it { should have_many :answers }
	it { should have_one :progress }
	it { should belong_to :task }
	it { should validate_presence_of :text }
	it { should validate_presence_of :answers }

	specify "should test right answers" do
		question.right_answers?([]) == true
		question.answers << answer
		question.right_answers?(["#{answer.id}"]) == true
	end
end