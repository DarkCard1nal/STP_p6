# frozen_string_literal: true

require 'json'
require_relative 'task_list'
require_relative 'task'

# An module for managing file tasks
module FileManager
	def self.upload_tasks_to_json(tasks, filename)
		tasks_as_hashes = tasks.map(&:to_h)
		File.write(filename, JSON.pretty_generate(tasks_as_hashes))
	end

	def self.download_tasks_from_json(filename)
		tasks_as_hashes = JSON.parse(File.read(filename), symbolize_names: true)
		task_list = TaskList.new
		tasks_as_hashes.each do |task_hash|
			task_list.push(Task.new(task_hash[:name], task_hash[:deadline], status: task_hash[:status]))
		end
		tasks_as_hashes.clear

		task_list
	end
end
