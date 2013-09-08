require 'spec_helper'

describe Admin::TasksController do
	let(:admin) { FactoryGirl.create(:admin) }
	let!(:task) { FactoryGirl.create(:task, admin_id: admin.id) }

	before(:each) do
		test_sign_in(admin)
	end

	describe "index" do
		let!(:another_admin) { FactoryGirl.create(:admin) }
		let!(:another_task) { FactoryGirl.create(:task, admin_id: another_admin.id) }

		it "should return admins tasks" do
			get :index
			expect(assigns(:tasks)).to eq([task])
		end
	end

	describe "new" do
		it "should not be nil" do
			get :new
			expect(assigns(:task)).to_not be_nil
			expect(assigns(:questions)).to_not be_nil
			expect(assigns(:answers)).to_not be_nil
		end
	end

	describe "create" do
		let(:task_attributes) { FactoryGirl.attributes_for(:task) }
		let(:question_attributes) { FactoryGirl.attributes_for(:question) }
		let(:answer_attributes) { FactoryGirl.attributes_for(:answer) }

		it "should create task" do
			post :create, task: task_attributes.merge(questions_attributes: { "0"  => question_attributes.merge(answers_attributes: { "0" => answer_attributes }) } )
			expect(assigns(:task)).to_not be_nil
			expect(assigns(:task)).to be_valid
			expect(assigns(:task).admin).to eq(admin)
		end
	end

	describe "search" do
		let!(:task) { FactoryGirl.create(:task) }
		let!(:another_task) { FactoryGirl.create(:task, admin_id: admin.id) }

		it "should return task" do
			post :search, search: "irst"
			expect(assigns(:tasks)).to eq([another_task])
		end
	end

	describe "update" do
		let!(:task) { FactoryGirl.create(:task) }
		let(:task_attributes) { FactoryGirl.attributes_for(:task, name: "update") }
		let(:question_attributes) { FactoryGirl.attributes_for(:question) }
		let(:answer_attributes) { FactoryGirl.attributes_for(:answer) }

		it "should update task" do
			put :create, task: task_attributes.merge(questions_attributes: { "0"  => question_attributes.merge(answers_attributes: { "0" => answer_attributes }) } )
			expect(assigns(:task).name).to eq("update")
		end
	end

	describe "destroy" do
		let(:task) { FactoryGirl.create(:task) }

		it "should delete task" do
			delete :destroy, id: task
			expect(Task.all).to eq([])
		end
	end
end