class PrimeChecker
  def self.prime?(number)
    return false if number <= 1
    (2..Math.sqrt(number).to_i).each do |i|
      return false if number % i == 0
    end
    true
  end
end


puts PrimeChecker.prime?(7)
puts PrimeChecker.prime?(10)
puts PrimeChecker.prime?(13)
puts PrimeChecker.prime?(1)


