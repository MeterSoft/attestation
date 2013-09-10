class Admin::ResultsController < Admin::BaseController
	inherit_resources

	has_scope :by_task_id

	def index
		index! do
			@results = current_admin.results
		end
	end
end
