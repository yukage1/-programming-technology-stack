# frozen_string_literal: true

# main.rb

require_relative 'task_manager'

manager = TaskManager.new

loop do
  puts "\nChoose an action:"
  puts "1. Add a task"
  puts "2. Delete a task"
  puts "3. Edit a task"
  puts "4. Mark a task as completed"
  puts "5. Show all tasks"
  puts "6. Filter tasks"
  puts "7. Exit"

  choice = gets.chomp.to_i

  case choice
  when 1
    print "Enter task description: "
    description = gets.chomp
    print "Enter deadline (YYYY-MM-DD): "
    deadline = gets.chomp
    manager.add_task(description, deadline)
    puts "Task added."
  when 2
    print "Enter task ID to delete: "
    id = gets.chomp.to_i
    manager.delete_task(id)
    puts "Task deleted."
  when 3
    print "Enter task ID to edit: "
    id = gets.chomp.to_i
    print "Enter new task description: "
    description = gets.chomp
    print "Enter new deadline (YYYY-MM-DD): "
    deadline = gets.chomp
    manager.edit_task(id, description, deadline)
    puts "Task updated."
  when 4
    print "Enter task ID to mark as completed: "
    id = gets.chomp.to_i
    manager.mark_completed(id)
    puts "Task marked as completed."
  when 5
    manager.tasks.each do |task|
      puts "ID: #{task.id}, Description: #{task.description}, Deadline: #{task.deadline}, Completed: #{task.completed}"
    end
  when 6
    print "Filter by completion status? (yes/no): "
    status_filter = gets.chomp.downcase
    status = nil
    if status_filter == 'yes'
      print "Enter status (true/false): "
      status = gets.chomp == 'true'
    end

    print "Filter by date before? (yes/no): "
    before_filter = gets.chomp.downcase
    before_date = nil
    if before_filter == 'yes'
      print "Enter date (YYYY-MM-DD): "
      before_date = gets.chomp
    end

    print "Filter by date after? (yes/no): "
    after_filter = gets.chomp.downcase
    after_date = nil
    if after_filter == 'yes'
      print "Enter date (YYYY-MM-DD): "
      after_date = gets.chomp
    end

    filtered_tasks = manager.filter_tasks(status: status, before_date: before_date, after_date: after_date)
    filtered_tasks.each do |task|
      puts "ID: #{task.id}, Description: #{task.description}, Deadline: #{task.deadline}, Completed: #{task.completed}"
    end
  when 7
    puts "Goodbye!"
    break
  else
    puts "Invalid choice, please try again."
  end
end
