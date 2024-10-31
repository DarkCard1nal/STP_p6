# frozen_string_literal: true

# class TaskList is responsible for interacting with tasks
class TaskList
	attr_reader :tasks

	def initialize(tasks = [])
		@tasks = tasks
	end

	def count
		@tasks.size
	end

	def push(task)
		@tasks.push(task)
	end

	def get(index)
		if index.negative? || index >= @tasks.size
			nil
		else
			@tasks[index]
		end
	end

	def delete_at(index)
		@tasks.delete_at(index)
	end

	def change(index, new_task)
		@tasks[index] = new_task
	end

	def clear
		@tasks.clear
	end

	def sort
		@tasks.sort_by! { |task| [task.status ? 1 : 0, task.deadline, task.name] }
	end

	def filter_tasks_by_field(field, value)
		@tasks.select { |task| task.send(field).to_s.casecmp(value.to_s).zero? }
	end

	def print_to_s(tasks = @tasks)
		result = "№, Name, Status, Dedline \n"
		tasks.each_with_index do |task, i|
			result += "#{i + 1}, #{task.name}, #{task.status}, #{task.deadline} \n"
		end

		result
	end
end
