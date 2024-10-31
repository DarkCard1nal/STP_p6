# frozen_string_literal: true

require 'rspec'
require 'json'
require 'fileutils'
require_relative '../file_manager'
require_relative '../task'
require_relative '../task_list'

RSpec.describe FileManager do # rubocop:disable Metrics/BlockLength
	let(:task) { Task.new('Task 1', '2024-12-31') }
	let(:task_list) { TaskList.new.tap { |tl| tl.push(task) } }
	let(:valid_file_path) { 'valid_tasks.json' }
	let(:invalid_file_path) { 'invalid_tasks.json' }

	after(:each) do
		FileUtils.rm_f(valid_file_path)
	end

	describe '.upload_tasks_to_json' do
		context 'when the file is writable' do
			it 'writes tasks to JSON file successfully' do
				result = FileManager.upload_tasks_to_json(task_list.tasks, valid_file_path, invalid_file_path)

				expect(result).to be true
				expect(File.exist?(valid_file_path)).to be true
				expect(JSON.parse(File.read(valid_file_path))).to eq([{ 'name' => 'Task 1', 'deadline' => '2024-12-31',
																																																												'status' => false }])
			end
		end

		context 'when both files are not writable' do
			before do
				allow(File).to receive(:exist?).and_return(true)
				allow(File).to receive(:writable?).and_return(false)
			end

			it 'returns false and prints an error message' do
				expect { FileManager.upload_tasks_to_json(task_list.tasks, valid_file_path, invalid_file_path) }
					.to output(/Error! Failed to write to files, check file access/).to_stdout

				expect(FileManager.upload_tasks_to_json(task_list.tasks, valid_file_path, invalid_file_path)).to be false
			end
		end
	end

	describe '.download_tasks_from_json' do
		context 'when the file is readable' do
			before do
				File.write(valid_file_path, JSON.pretty_generate([{ name: 'Task 1', deadline: '2024-12-31', status: false }]))
			end

			it 'reads tasks from JSON file successfully' do
				result = FileManager.download_tasks_from_json(valid_file_path)

				expect(result.count).to eq(1)
				expect(result.get(0).name).to eq('Task 1')
				expect(result.get(0).deadline).to eq('2024-12-31')
				expect(result.get(0).status).to be false
			end
		end

		context 'when the file is not readable' do
			it 'prints an error message' do
				expect { FileManager.download_tasks_from_json(invalid_file_path) }
					.to output(/Error! File could not be read, check file access/).to_stdout
			end
		end
	end

	describe '.readable?' do
		context 'when the file exists and is readable' do
			before do
				allow(File).to receive(:exist?).with(valid_file_path).and_return(true)
				allow(File).to receive(:readable?).with(valid_file_path).and_return(true)
			end

			it 'returns true' do
				expect(FileManager.readable?(valid_file_path)).to be true
			end
		end

		context 'when the file does not exist or is not readable' do
			before do
				allow(File).to receive(:exist?).with(invalid_file_path).and_return(false)
				allow(File).to receive(:readable?).with(invalid_file_path).and_return(false)
			end

			it 'returns false' do
				expect(FileManager.readable?(invalid_file_path)).to be false
			end
		end
	end
end
