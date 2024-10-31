# frozen_string_literal: true

require 'rspec'
require_relative '../task_list'
require_relative '../task'

RSpec.describe TaskList do # rubocop:disable Metrics/BlockLength
	let(:task1) { Task.new('Task 1', '2024-12-31', status: false) }
	let(:task2) { Task.new('Task 2', '2024-01-01', status: true) }
	let(:task3) { Task.new('Task 3', '2024-06-15', status: false) }
	let(:task_list) { TaskList.new([task1, task2, task3]) }

	describe '#initialize' do
		it 'initializes with an empty task list' do
			task_list = TaskList.new
			expect(task_list.count).to eq(0)
		end

		it 'initializes with a given array of tasks' do
			expect(task_list.count).to eq(3)
		end
	end

	describe '#push' do
		it 'adds a task to the list' do
			task4 = Task.new('Task 4', '2024-07-20')
			task_list.push(task4)
			expect(task_list.count).to eq(4)
			expect(task_list.get(3)).to eq(task4)
		end
	end

	describe '#get' do
		it 'returns the task at a valid index' do
			expect(task_list.get(0)).to eq(task1)
		end

		it 'returns nil for a negative index' do
			expect(task_list.get(-1)).to be_nil
		end

		it 'returns nil for an index out of bounds' do
			expect(task_list.get(5)).to be_nil
		end
	end

	describe '#delete_at' do
		it 'removes the task at the given index' do
			task_list.delete_at(1)
			expect(task_list.count).to eq(2)
			expect(task_list.get(1)).to eq(task3)
		end
	end

	describe '#change' do
		it 'changes the task at the given index' do
			new_task = Task.new('New Task', '2024-09-01')
			task_list.change(0, new_task)
			expect(task_list.get(0)).to eq(new_task)
		end
	end

	describe '#clear' do
		it 'removes all tasks from the list' do
			task_list.clear
			expect(task_list.count).to eq(0)
		end
	end

	describe '#sort' do
		it 'sorts tasks by status, deadline, and name' do
			task_list.sort
			expect(task_list.get(0)).to eq(task3) # Task 3 should be first (status false, deadline before Task 1)
			expect(task_list.get(1)).to eq(task1) # Task 1 should (status false, deadline before Task 3)
			expect(task_list.get(2)).to eq(task2) # Task 2 should be last (status true)
		end
	end

	describe '#filter_tasks_by_field' do
		it 'returns tasks that match the given field and value' do
			result = task_list.filter_tasks_by_field(:status, false)
			expect(result).to include(task1, task3)
			expect(result).not_to include(task2)
		end

		it 'returns tasks with case-insensitive matching for strings' do
			result = task_list.filter_tasks_by_field(:name, 'task 1')
			expect(result).to include(task1)
			expect(result).not_to include(task2)
		end
	end

	describe '#print_to_s' do
		it 'returns a string representation of tasks' do
			expected_output = "№, Name, Status, Dedline \n" \
																					"1, Task 1, false, 2024-12-31 \n" \
																					"2, Task 2, true, 2024-01-01 \n" \
																					"3, Task 3, false, 2024-06-15 \n"
			expect(task_list.print_to_s).to eq(expected_output)
		end
	end
end
