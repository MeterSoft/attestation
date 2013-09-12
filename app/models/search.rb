module Search
 	
	def find_by(term, option = {})
		# by_mark = results.where("mark = ?", "%#{term}%")
		by_mark = []
		by_current_name = results.send("find_by_#{resource}_name", term)
		by_task_name = results.find_by_task_name(term)

		option[:json] ? (by_mark.map{ |r| r.mark.to_s } + by_current_name.map{ |r| r.send(resource).full_name } + by_task_name.map{ |r| r.task.name }).uniq
									: (by_mark + by_current_name + by_task_name).uniq
	end

	protected

	def resource
		self.class.name == "Admin" ? "user" : "admin"
	end
end