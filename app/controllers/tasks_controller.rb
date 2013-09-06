class TasksController < ApplicationController
	before_filter :find_task, only: [:create, :show, :update]

	def index
		@tasks = Task.shared
	end

	def create
		@result = Result.find_by_task_id_and_user_id(@task.id, current_user.id)
		if @task.iteration
			@result = Result.find_or_create_by_task_id_and_user_id_and_finished(@task.id, current_user.id, finished: false)
			redirect_to task_path(@task)
		else
			render :destroy
		end
	end

	def show
		@question = @task.next_question(current_user.id) if @task
		unless @question
			@result = Result.find_by_user_id_and_task_id_and_finished(current_user.id, @task.id, false)
			@result.update_attributes(finished: true)
			@result.progresses.map(&:destroy)
			render :destroy
		end 
	end

	def update
		@result = Result.find_by_user_id_and_task_id_and_finished(current_user.id, params[:id], false)
		@question = Question.find_by_id(params[:task][:questions_attributes]["0"][:id])
		if @task.check?
			answer_ids = params[:task][:questions_attributes]["0"][:answer_ids].reject(&:empty?)
			@question.right_answers?(answer_ids) ? @result.up_mark(@task.rate) : nil
		else
			WriteAnswer.create(task_id: @task.id, question_id: @question.id, result_id: @result.id, user_id: current_user.id, text: params[:text][0])
		end
		Progress.create(task_id: @task.id, user_id: current_user.id, question_id: @question.id, result_id: @result.id)
		redirect_to task_path(@task)
	end

	def search
		@tasks = Task.shared.where("name LIKE ?", "%#{params[:search]}%")
		render :index
	end

	private

	def find_task
		@task = Task.find_by_id(params[:task_id] || params[:id])
	end

end
