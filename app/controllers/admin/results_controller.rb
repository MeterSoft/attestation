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
        @results = current_admin.find_by(params[:term]) 
        render :index 
      end
      format.json { render json: current_admin.find_by(params[:term], json: true) }
    end
  end
end
