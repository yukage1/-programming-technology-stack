# task.rb

require 'date'

class Task
  attr_accessor :id, :description, :deadline, :completed

  def initialize(id, description, deadline, completed = false)
    @id = id
    @description = description
    @deadline = Date.parse(deadline)
    @completed = completed
  end

  def to_hash
    {
      id: @id,
      description: @description,
      deadline: @deadline.to_s,
      completed: @completed
    }
  end

  def self.from_hash(hash)
    new(hash['id'], hash['description'], hash['deadline'], hash['completed'])
  end
end# frozen_string_literal: true

