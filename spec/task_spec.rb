# frozen_string_literal: true

require 'rspec'
require_relative '../task'

RSpec.describe Task do # rubocop:disable Metrics/BlockLength
	describe '#initialize' do
		it 'creates a task with given name, deadline, and default status' do
			task = Task.new('Task 1', '2024-12-31')

			expect(task.name).to eq('Task 1')
			expect(task.deadline).to eq('2024-12-31')
			expect(task.status).to be false
		end

		it 'creates a task with given status' do
			task = Task.new('Task 2', '2024-11-30', status: true)

			expect(task.status).to be true
		end
	end

	describe '#change_status' do
		it 'changes the status of the task from false to true' do
			task = Task.new('Task 3', '2024-12-31')

			task.change_status

			expect(task.status).to be true
		end

		it 'changes the status of the task from true to false' do
			task = Task.new('Task 4', '2024-11-30', status: true)

			task.change_status

			expect(task.status).to be false
		end
	end

	describe '#to_h' do
		it 'returns a hash representation of the task' do
			task = Task.new('Task 5', '2024-10-31')

			expect(task.to_h).to eq({ name: 'Task 5', deadline: '2024-10-31', status: false })
		end

		it 'returns a hash with the correct status' do
			task = Task.new('Task 6', '2024-10-31', status: true)

			expect(task.to_h).to eq({ name: 'Task 6', deadline: '2024-10-31', status: true })
		end
	end
end
