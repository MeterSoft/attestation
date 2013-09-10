class Admin::TasksController < Admin::BaseController
	inherit_resources
	
	def index
		index! do |format|
			@tasks = current_admin.tasks
			format.csv do 
				send_data MigrateCSV.to_csv(@tasks), filename: "#{Time.now.strftime("%Y%m%d")}.csv"
			end
		end
	end

	def new
		@task = current_admin.tasks.build
		@questions = @task.questions.build
		@answers = @questions.answers.build
	end

	def show
		show! do |format|
			format.csv do 
				send_data MigrateCSV.to_csv([@task]), filename: "#{Time.now.strftime("%Y%m%d")}.csv"
			end
		end
	end

	def create
		create!
		current_admin.tasks << @task
	end

	def search
		@tasks = current_admin.tasks.where("name LIKE ?", "%#{params[:search]}%")
		render :index
	end

	def import
		MigrateCSV.import(params[:file]) ? flash[:notice] = "Succsess import" : flash[:error] = "Error import"
		redirect_to admin_tasks_path
	end

end