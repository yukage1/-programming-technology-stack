# task_manager.rb

require_relative 'task'
require 'json'

class TaskManager
  attr_accessor :tasks

  def initialize
    @tasks = []
    load_tasks
  end

  def add_task(description, deadline)
    id = (@tasks.map(&:id).max || 0) + 1
    task = Task.new(id, description, deadline)
    @tasks << task
    save_tasks
  end

  def delete_task(id)
    @tasks.reject! { |task| task.id == id }
    save_tasks
  end

  def edit_task(id, new_description, new_deadline)
    task = @tasks.find { |t| t.id == id }
    if task
      task.description = new_description
      task.deadline = Date.parse(new_deadline)
      save_tasks
    else
      puts "Task with ID #{id} not found."
    end
  end

  def mark_completed(id)
    task = @tasks.find { |t| t.id == id }
    if task
      task.completed = true
      save_tasks
    else
      puts "Task with ID #{id} not found."
    end
  end

  def filter_tasks(status: nil, before_date: nil, after_date: nil)
    result = @tasks
    result = result.select { |task| task.completed == status } unless status.nil?
    result = result.select { |task| task.deadline <= Date.parse(before_date) } unless before_date.nil?
    result = result.select { |task| task.deadline >= Date.parse(after_date) } unless after_date.nil?
    result
  end

  private

  def save_tasks
    data = @tasks.map(&:to_hash)
    File.open('tasks.json', 'w') { |f| f.write(JSON.pretty_generate(data)) }
  end

  def load_tasks
    if File.exist?('tasks.json')
      data = JSON.parse(File.read('tasks.json'))
      @tasks = data.map { |task_data| Task.from_hash(task_data) }
    else
      @tasks = []
    end
  end
end# frozen_string_literal: true

