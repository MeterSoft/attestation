require 'spec_helper'

describe Result do
	let(:task) { FactoryGirl.create(:task, time: 1) }
	let!(:result) { FactoryGirl.create(:result, task_id: task.id) }

	it { should belong_to :task }
	it { should have_many :progresses }
	it { should have_many :write_answers }
 	it { should belong_to :user }
 	
	specify "should up mark" do
		result.up_mark(5)
		result.mark.should eq(5)
	end

	specify "should test valid time" do
		result = create(:result, task_id: task.id, created_at: Time.now + 500)
		result.time_valid?.should be_false
	end

	specify "should test invalid time" do
		result = create(:result, task_id: task.id, created_at: Time.now - 500)
		result.time_valid?.should be_true
	end

	specify "should be not finished" do
		result.finished?.should be_false
	end

	specify "should return by task id" do
		Result.by_task_id(task.id).should eq([result])
	end
end