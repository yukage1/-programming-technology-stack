def slice_cake(cake)
  rows = cake.size
  cols = cake[0].size
  raisins = []

  rows.times do |i|
    cols.times do |j|
      raisins << [i, j] if cake[i][j] == 'o'
    end
  end

  n = raisins.size
  return [] if n < 2 || n > 10

  horizontal_slices = []
  last_index = 0
  raisins.each_with_index do |(row, _), index|
    next_row = raisins[index + 1] ? raisins[index + 1][0] : rows
    horizontal_slices << cake[last_index..row]
    last_index = row + 1
  end
  if valid_split?(horizontal_slices, raisins)
    return horizontal_slices
  end

  vertical_slices = []
  last_index = 0
  raisins.each_with_index do |(_, col), index|
    next_col = raisins[index + 1] ? raisins[index + 1][1] : cols
    slice = cake.map { |row| row[last_index..col] }
    vertical_slices << slice
    last_index = col + 1
  end

  return vertical_slices if valid_split?(vertical_slices, raisins)

  form_based_slices = []
  raisins.each do |(row, col)|
    slice = Array.new(rows) { '.' * cols }
    slice[row][col] = 'o'
    form_based_slices << slice
  end

  form_based_slices
end

def valid_split?(slices, raisins)
  slices.all? do |slice|
    slice.join.count('o') == 1
  end
end

#Example of cake
cake = [
  ".o......",
  "......o.",
  "....o...",
  "..o....."
]

result = slice_cake(cake)
puts "Result:"
result.each do |slice|
  slice.each { |row| puts row }
  puts "---"
end
