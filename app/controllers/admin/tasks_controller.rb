class Admin::TasksController < Admin::BaseController
	inherit_resources
	
	def new
		@task = current_admin.tasks.build
		@questions = @task.questions.build
		@answers = @questions.answers.build
	end

	def create
		create!
		current_admin.tasks << @task
	end
end