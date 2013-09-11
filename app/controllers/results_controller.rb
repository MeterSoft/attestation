class ResultsController < ApplicationController
	inherit_resources
	has_scope :by_task_id
  def index
  	index! do
			@results = current_user.results
		end
  end
end
