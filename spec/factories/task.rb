FactoryGirl.define do
	factory :task do
		name 'first task'
		shared true
		task_type "check"
		max_mark 12
		iteration false
		time nil
		after(:build) do |task|
			task.questions << FactoryGirl.create(:question)
		end
	end

	factory :question do
		text 'some question'
		after(:build) do |question|
			3.times {
				question.answers << FactoryGirl.create(:answer)
			}
		end
	end

	factory :answer do
		text 'some answer'
		correct false
	end

	factory :result do
		user_id 1
		task_id 1
		finished false
	end

	factory :progress do
		user_id 1 
		task_id 1 
		result_id 1
	end
end