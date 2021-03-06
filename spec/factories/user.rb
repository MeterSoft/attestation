FactoryGirl.define do
	sequence :email do |n|
		"email#{n}@factory.com"
	end

	factory :user do
		first_name 'test'
		last_name 'test'
		email
		password 'password'
	end

	factory :admin do
		first_name 'test'
		last_name 'test'
		email
		password 'password'
	end
end