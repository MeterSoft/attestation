class ResultsController < ApplicationController
	has_scope :by_task_id
  def index
		@results = current_user.results
  end
end
