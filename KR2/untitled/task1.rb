def process_array(arr, proc)
  arr.map { |num| proc.call(num) }
end

# Приклад використання:
square = Proc.new { |x| x * x }
numbers = [1, 2, 3, 4]

result = process_array(numbers, square)
puts result.inspect

