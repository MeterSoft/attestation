module Search
 	
	def search(term)
		@by_mark = results.where("mark LIKE ?", "%#{term}%")
		@by_current_name = results.send("find_by_#{resource}_name", term)
		@by_task_name = results.find_by_task_name(term)
	end

	def find(term)
		search(term)
		(@by_mark + @by_current_name + @by_task_name).uniq
	end

	def find_json(term)
		search(term)
		(@by_mark.map{ |result| result.mark.to_s } + @by_current_name.map{ |result| result.send(resource).full_name } + @by_task_name.map{ |result| result.task.name }).uniq
	end

	def resource
		self.class.name == "Admin" ? "user" : "admin"
	end
end