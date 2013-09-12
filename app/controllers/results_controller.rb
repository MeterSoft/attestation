class ResultsController < ApplicationController
	has_scope :by_task_id
  def index
		@results = current_user.results
  end

  def search
		respond_to do |format|
      format.html do 
        @results = current_user.find_by(params[:term]) 
        render :index 
      end
      format.json { render json: current_user.find_by(params[:term], json: true) }
    end
	end
end
