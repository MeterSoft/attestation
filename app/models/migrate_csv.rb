class MigrateCSV

	def self.to_csv(tasks, options = {})
    CSV.generate(options) do |csv|
      csv << ["task"]
      tasks.each do |task|
        csv << [task.attributes.merge!(build_question(task)).to_json]
      end
    end
  end

  def self.build_question(task)
    questions_attr = {}
    task.questions.each_with_index do |question, index|
      questions_attr.merge!({ index.to_s => question.attributes.merge(build_answer(question)) })
    end
    return { questions_attributes: questions_attr }
  end

  def self.build_answer(question)
    answers_attr = {}
    question.answers.each_with_index do |answer, index|
      answers_attr.merge!({ index.to_s => answer.attributes })
    end
    return { answers_attributes: answers_attr }
  end

  def self.import(file)
	  CSV.foreach(file.path, headers: true) do |row|
	    # product = find_by_id(row["id"]) || new
	    task = Task.new(slice_attr(JSON.parse(row[0])))
	    task.save!
	  end
	  true
	end

	def self.slice_attr(task)
		task["questions_attributes"].each do |key, value|
			task["questions_attributes"][key] = value.slice(*Question.accessible_attributes)
			value["answers_attributes"].each do |k,v|
				task["questions_attributes"][key]["answers_attributes"][k] = v.slice(*Answer.accessible_attributes)
			end
		end
		task.slice(*Task.accessible_attributes)
	end
end