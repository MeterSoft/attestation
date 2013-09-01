class Admin::ResultsController < Admin::BaseController
	inherit_resources

	has_scope :by_task_id
end
