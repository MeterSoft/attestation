class Admin::ResultsController < Admin::BaseController
	inherit_resources

	has_scope :by_task_id

	def index
		index! do
			@results = current_admin.results
		end
	end

	def search
		respond_to do |format|
			format.html do
				@results = current_admin.find(params[:term])
				render :index 
			end
			format.json do
				@results = current_admin.find_json(params[:term])
				render json: @results
			end
		end
	end

end
