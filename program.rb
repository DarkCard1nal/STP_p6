# frozen_string_literal: true

require_relative 'constants'
require_relative 'file_manager'
require_relative 'task_list'
require_relative 'task'

def get_task_dy_index(task_list)
	puts('Enter the index of the task:')
	index = gets.chomp.strip.to_i
	task = task_list.get(index - 1)
	puts('Task with this index was not found') if task.nil?

	[task, index]
end

def help # rubocop:disable Metrics/MethodLength
	puts(Constants::AUTHOR)
	puts('0 - Exit')
	puts('1 - Display tasks')
	puts('2 - Add task')
	puts('3 - Change task by idex')
	puts('4 - Change the status of a task by index')
	puts('5 - Delete a task by idex')
	puts('6 - Sort tasks')
	puts('7 - Clear tasks')
	puts('8 - Display completed tasks')
	puts('9 - Display uncompleted tasks')
	puts('10 - Display tasks by filter name')
	puts('11 - Display tasks by filter deadline')
end

def add_task(task_list)
	puts('Add task')
	puts('Enter the name of the task:')
	name = gets.chomp.strip
	puts('Enter the deadline of the task:')
	deadline = gets.chomp.strip

	task_list.push(Task.new(name, deadline))
	puts('Task Added')
end

def change_task_by_idex(task_list) # rubocop:disable Metrics/AbcSize
	puts('Change task by idex')
	task, index = get_task_dy_index(task_list)
	return if task.nil?

	puts("Task: {name: #{task.name}; deadline: #{task.deadline}; status: #{task.status}}")

	puts('Enter the new name of the task:')
	name = gets.chomp.strip
	puts('Enter the new deadline of the task:')
	deadline = gets.chomp.strip

	task_list.change(index - 1, Task.new(name, deadline))
	puts('Task Changed')
end

def change_the_task_status_by_index(task_list)
	puts('Change the status of a task by index')
	task = get_task_dy_index(task_list)[0]
	return if task.nil?

	task.change_status
	puts('Task Changed')
end

def delete_task_by_idex(task_list)
	puts('Delete a task by idex')
	task, index = get_task_dy_index(task_list)
	return if task.nil?

	puts("Task: {name: #{task.name}; deadline: #{task.deadline}; status: #{task.status}}")
	task_list.delete_at(index - 1)
	puts('Task Deleted')
end

file_path = Constants::FILE_PATH
file_path = ARGV[0] unless ARGV.empty?

task_list = FileManager.download_tasks_from_json(file_path)
help

loop do # rubocop:disable Metrics/BlockLength
	puts('Choose an action:')
	input = gets.chomp.strip
	case input
	when '0'
		puts('Exit')
		if FileManager.upload_tasks_to_json(task_list.tasks, file_path, Constants::FILE_BACKUP_PATH)
			puts('Data saved, program execution completed')
			break
		else
			puts('The data was not saved, do you really want to exit (data will be lost)? [Y/n]')
			input = gets.chomp.strip
			if input.casecmp('y').nil?
				puts('Program execution completed')
				break
			else
				puts('Action canceled')
			end
		end
	when '1'
		puts('Display tasks')
		puts(task_list.print_to_s)
	when '2'
		add_task(task_list)
	when '3'
		change_task_by_idex(task_list)
	when '4'
		change_the_task_status_by_index(task_list)
	when '5'
		delete_task_by_idex(task_list)
	when '6'
		puts('Sort tasks')
		task_list.sort
		puts('tasks Sorted')
	when '7'
		puts('Clear tasks')
		task_list.clear
		puts('tasks is empty')
	when '8'
		puts('Display completed tasks')
		puts(task_list.print_to_s(task_list.filter_tasks_by_field(:status, true)))
	when '9'
		puts('Display uncompleted tasks')
		puts(task_list.print_to_s(task_list.filter_tasks_by_field(:status, false)))
	when '10'
		puts('Display tasks by filter name')
		puts('Enter the name of the task:')
		name = gets.chomp.strip
		puts(task_list.print_to_s(task_list.filter_tasks_by_field(:name, name)))
	when '11'
		puts('Display tasks by filter deadline')
		puts('Enter the deadline of the task:')
		deadline = gets.chomp.strip
		puts(task_list.print_to_s(task_list.filter_tasks_by_field(:deadline, deadline)))
	else
		puts('Command not found!')
		help
	end
end
