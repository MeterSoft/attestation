require 'spec_helper'

describe Result do
	let(:result) { FactoryGirl.create(:result) }
	let(:task) { FactoryGirl.create(:task, time: 1) }

	it { should belong_to :task }
	it { should have_many :progresses }
	it { should have_many :write_answers }
 	it { should belong_to :user }
 	
	specify "should up mark" do
		result.up_mark(5)
		result.mark == 5
	end

	specify "should test valid time" do
		result = create(:result, task_id: task.id)
		result.time_valid? == true
		result = create(:result, task_id: task.id, created_at: Time.now - 500)
		result.time_valid? == false
	end

	specify "should be not finished" do
		result.finished? == false
	end

	specify "should return by task id" do
		Result.by_task_id(result.id) == [result]
	end
end