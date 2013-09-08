require 'spec_helper'

describe Answer do
	let(:answer) { FactoryGirl.create(:answer, correct: true) }

	it { should belong_to :question }
	it { should validate_presence_of :text }

	specify "should test in right" do
		Answer.right == [answer]
	end
end