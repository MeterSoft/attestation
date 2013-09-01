FactoryGirl.define do
	factory :task do
		name 'first task'
		shared true
	end

	factory :question do
		text 'some question'
	end

	factory :answer do
		text 'some answer'
	end
end