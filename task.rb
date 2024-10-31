# frozen_string_literal: true

# class Task is responsible for one task
class Task
	attr_accessor :name, :deadline
	attr_reader :status

	def initialize(name, deadline, status: false)
		@name = name
		@deadline = deadline
		@status = status
	end

	def change_status
		@status = !@status
	end
end
