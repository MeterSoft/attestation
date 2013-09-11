require 'spec_helper'

describe Task do
	let!(:task) { FactoryGirl.create(:task) }

	it { should have_many :questions }
	it { should have_many :results }
	it { should have_many :progresses }
	it { should belong_to :admin }
	it { should validate_presence_of :name }
	it { should validate_presence_of :questions }
	it { should validate_presence_of :max_mark }

	specify "should return shared tasks" do
		another = create(:task, shared: false)
		Task.shared.should eq([task])
	end

	specify "should not be write" do
		task.write?.should be_false
	end

	specify "should be check" do
		task.check?.should be_true
	end

	specify "should not be time" do
		task.time?.should be_false
	end

	specify "should return next questions" do
		task.next_question(1).should eq(task.questions[0])
	end

	specify "validete mark" do
		build(:task, max_mark: "1ds1").should_not be_valid
		build(:task, max_mark: "-13").should_not be_valid
		build(:task, max_mark: "23 23").should_not be_valid
	end
end