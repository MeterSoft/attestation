class ResultsController < ApplicationController
	has_scope :by_task_id
  def index
		@results = current_user.results
  end

  def search
		respond_to do |format|
			format.html do
				@results = current_user.find(params[:term])
				render :index 
			end
			format.json do
				@results = current_user.find_json(params[:term])
				render json: @results
			end
		end
	end
end
