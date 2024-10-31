# frozen_string_literal: true

require 'json'
require_relative 'task_list'
require_relative 'task'

# An module for managing file tasks
module FileManager
	def self.upload_tasks_to_json(tasks, file_path1, file_path2)
		file_path = writable_file(file_path1, file_path2)

		if file_path.nil?
			puts("Error! Failed to write to files, check file access: #{file_path1}, #{file_path2}")
			false
		else
			tasks_as_hashes = tasks.map(&:to_h)
			File.write(file_path, JSON.pretty_generate(tasks_as_hashes))
			true
		end
	end

	def self.download_tasks_from_json(file_path) # rubocop:disable Metrics/MethodLength
		task_list = TaskList.new

		if readable?(file_path)
			tasks_as_hashes = JSON.parse(File.read(file_path), symbolize_names: true)
			tasks_as_hashes.each do |task_hash|
				task_list.push(Task.new(task_hash[:name], task_hash[:deadline], status: task_hash[:status]))
			end
			tasks_as_hashes.clear

			puts("Tasks data downloaded from file: #{file_path}")
		else
			puts("Error! File could not be read, check file access: #{file_path}")
		end

		task_list
	end

	def self.writable_file(file_path1, file_path2)
		return file_path1 if File.exist?(file_path1) ? File.writable?(file_path2) : true
		return file_path2 if File.exist?(file_path2) ? File.writable?(file_path2) : true

		nil
	end

	def self.readable?(file_path)
		File.exist?(file_path) && File.readable?(file_path)
	end
end
