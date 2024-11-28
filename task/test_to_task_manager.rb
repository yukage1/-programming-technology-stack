# test_task_manager.rb

require 'minitest/autorun'
require_relative 'task_manager'

class TestTaskManager < Minitest::Test
  def setup
    @manager = TaskManager.new
    @manager.tasks = []
  end

  def test_add_task
    @manager.add_task('Test Task', '2024-01-01')
    assert_equal 1, @manager.tasks.size
    assert_equal 'Test Task', @manager.tasks.first.description
  end

  def test_delete_task
    @manager.add_task('Task for deletion', '2024-01-01')
    id = @manager.tasks.first.id
    @manager.delete_task(id)
    assert_equal 0, @manager.tasks.size
  end

  def test_edit_task
    @manager.add_task('Old Task', '2024-01-01')
    id = @manager.tasks.first.id
    @manager.edit_task(id, 'New Task', '2024-02-01')
    assert_equal 'New Task', @manager.tasks.first.description
    assert_equal Date.parse('2024-02-01'), @manager.tasks.first.deadline
  end

  def test_mark_completed
    @manager.add_task('Unfinished Task', '2024-01-01')
    id = @manager.tasks.first.id
    @manager.mark_completed(id)
    assert @manager.tasks.first.completed
  end

  def test_filter_tasks
    @manager.add_task('Task number 1', '2024-01-01')
    @manager.add_task('Task number 2', '2024-04-01')
    @manager.mark_completed(@manager.tasks.first.id)

    completed_tasks = @manager.filter_tasks(status: true)
    assert_equal 1, completed_tasks.size
    assert_equal 'Task number 1', completed_tasks.first.description

    date_filtered_tasks = @manager.filter_tasks(before_date: '2024-02-01')
    assert_equal 1, date_filtered_tasks.size
    assert_equal 'Task number 1', date_filtered_tasks.first.description
  end
end# frozen_string_literal: true

