class Admin::TasksController < Admin::BaseController
	inherit_resources
	
	def index
		index! do
			@tasks = current_admin.tasks
		end
	end

	def new
		@task = current_admin.tasks.build
		@questions = @task.questions.build
		@answers = @questions.answers.build
	end

	def create
		create!
		current_admin.tasks << @task
	end

	def search
		@tasks = current_admin.tasks.where("name LIKE ?", "%#{params[:search]}%")
		render :index
	end
end