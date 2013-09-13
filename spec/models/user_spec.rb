require 'spec_helper'

describe User do
	let(:user) { FactoryGirl.create(:user) }

	it { should have_many :results }
	it { should validate_presence_of :first_name }
	it { should validate_presence_of :last_name }

	specify "has a full_name" do
		#user.full_name.should_not be_false
		FactoryGirl.build(:user, first_name: "Eugene", last_name: "Korpan").full_name.should eq("Eugene Korpan")
	end

end