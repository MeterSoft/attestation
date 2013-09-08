require 'spec_helper'

describe TasksController do
	let(:user) { FactoryGirl.create(:user) }

	before(:each) do
		test_sign_in(user)
	end

	describe "index" do
		let(:task) { FactoryGirl.create(:task) }
		let(:another_task) { FactoryGirl.create(:task, shared: false) }

		it "should return shared tasks" do 
			get :index
			expect(assigns(:tasks)).to eq([task])
		end
	end

	describe "create" do
		let(:task) { FactoryGirl.create(:task) }
		let(:iteration_task) { FactoryGirl.create(:task, iteration: true) }

		it "should not start if test not iteration" do
			create(:result, user_id: user.id, task_id: task.id, finished: true)
			post :create, id: task
			expect(assigns(:task)).to_not be_nil
			expect(assigns(:result)).to_not be_nil
			expect(flash[:error]).to_not be_nil
			expect(subject).to render_template :destroy
		end

		it "should not start if test already finished" do
			result = create(:result, user_id: user.id, task_id: task.id, finished: true)
			post :create, id: task
			expect(assigns(:task)).to_not be_nil
			expect(assigns(:result)).to eq(result)
			expect(flash[:error]).to_not be_nil
			expect(subject).to render_template :destroy
		end

		it "should start test if iteration" do
			post :create, id: iteration_task
			expect(assigns(:task)).to_not be_nil
			expect(assigns(:result)).to_not be_nil
			expect(flash[:error]).to be_nil
			expect(subject).to redirect_to task_path(iteration_task)
		end

		it "should start test no started" do
			post :create, id: task
			expect(assigns(:task)).to_not be_nil
			expect(assigns(:result)).to_not be_nil
			expect(flash[:error]).to be_nil
			expect(subject).to redirect_to task_path(task)
		end

		it "should start test no finished" do
			create(:result, user_id: user.id, task_id: task.id, finished: false)
			post :create, id: task
			expect(assigns(:task)).to_not be_nil
			expect(assigns(:result)).to_not be_nil
			expect(flash[:error]).to be_nil
			expect(subject).to redirect_to task_path(task)
		end
	end

	describe "show" do
		let(:task) { FactoryGirl.create(:task) }

		it "should get next question" do
			get :show, id: task
			expect(assigns(:task)).to_not be_nil
			expect(assigns(:question)).to_not be_nil
			expect(flash[:error]).to be_nil
		end

		context "question" do
			before do 
				result = create(:result, user_id: user.id, task_id: task.id, finished: false)
				Task.any_instance.stub(:next_question).and_return(nil)
				create(:progress, user_id: user.id, task_id: task.id, result_id: result.id) 
			end

			it "should off test if question end" do
				get :show, id: task
				expect(assigns(:task)).to_not be_nil
				expect(assigns(:question)).to be_nil
				expect(flash[:notice]).to_not be_nil
				expect(assigns(:result).finished).to eq(true)
				expect(assigns(:result).progresses.reload).to eq([])
			end
		end

		context "time" do
			let(:task) { FactoryGirl.create(:task, time: 1) }

			before { Result.any_instance.stub(:time_valid?).and_return(true) }

			it "should off test if time end" do
				create(:result, user_id: user.id, task_id: task.id, finished: false)
				get :show, id: task
				expect(flash[:error]).to_not be_nil
				expect(subject).to render_template :destroy
			end
		end
	end

	describe "search" do
		let!(:task) { FactoryGirl.create(:task) }
		let!(:another_task) { FactoryGirl.create(:task, shared: false) }

		it "should return task" do
			post :search, search: "irst"
			expect(assigns(:tasks)).to eq([task])
		end
	end

	describe "update" do
		let(:task) { FactoryGirl.create(:task) }

		it "should test question if test check" do
			result = create(:result, user_id: user.id, task_id: task.id, finished: false)
			put :update, { id: task.id, task: { questions_attributes: { "0" => { answer_ids: [""], id: task.questions.first.id } } } }
			expect(assigns(:question)).to_not be_nil
			expect(assigns(:result).mark).to_not eq(result)
			expect(assigns(:task)).to_not be_nil
		end
	end

	context "type write" do
		let(:task) { FactoryGirl.create(:task, task_type: "write") }

		it "should create write answer" do
			result = create(:result, user_id: user.id, task_id: task.id, finished: false)
			put :update, { id: task.id, text: ["test"], task: { questions_attributes: { "0" => { id: task.questions.first.id } } } }
			expect(assigns(:result).write_answers).to have(1).items
			expect(subject).to redirect_to task_path(task)
		end
	end
end