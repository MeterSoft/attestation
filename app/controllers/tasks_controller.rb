class TasksController < ApplicationController
	before_filter :find_task, only: [:create, :show, :update]

	def index
		@tasks = Task.shared
	end

	def create
		@result = Result.find_or_create_by_task_id_and_mark_and_mark_type_and_user_id(@task.id, "0", "@task.mark_type", current_user.id)
		redirect_to task_path(@task)
	end

	def show
		@question = @task.next_question(current_user.id) if @task
		unless @question
			@result = Result.find_by_user_id_and_task_id(current_user.id, @task.id)
			render :destroy
		end 
	end

	def update
		@result = Result.find_by_user_id_and_task_id(current_user.id, params[:id])
		@question = Question.find_by_id(params[:task][:questions_attributes]["0"][:id])
		answer_ids = params[:task][:questions_attributes]["0"][:answer_ids].reject(&:empty?)
		@question.right_answers?(answer_ids) ? @result.up_mark : nil
		Progress.create(task_id: @task.id, user_id: current_user.id, question_id: @question.id, result_id: @result.id)
		redirect_to task_path(@task)
	end

	private

	def find_task
		@task = Task.find_by_id(params[:task_id] || params[:id])
	end
end
