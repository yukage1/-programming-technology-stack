
numbers = [1, 2, 3, 4, 5]

ractor = Ractor.new do

  array = Ractor.receive

  Ractor.yield(array.map { |n| n * 2 })
end

ractor.send(numbers, move: true)

result = ractor.take

puts "Оброблений масив: #{result.inspect}"
