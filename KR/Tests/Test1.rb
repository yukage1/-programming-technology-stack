def count_greater(arr, val)
  arr.select { |x| x > val }.size
end

puts count_greater([1, 5, 10, 15, 20], 10)


