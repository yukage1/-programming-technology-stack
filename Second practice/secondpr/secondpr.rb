def precedence(op)
  case op
  when '+', '-'
    return 1
  when '*', '/'
    return 2
  else
    return 0
  end
end

def is_operator?(c)
  ['+', '-', '*', '/'].include?(c)
end

def to_rpn(expression)
  output = []
  operators = []

  tokens = expression.scan(/\d+|[+\-*\/]/)

  tokens.each do |token|
    if token.match?(/\d+/)
      output << token
    elsif is_operator?(token)
      while !operators.empty? && precedence(operators.last) >= precedence(token)
        output << operators.pop
      end
      operators << token
    end
  end

  while !operators.empty?
    output << operators.pop
  end

  output.join(' ')
end

puts "Enter a mathematical expression:"
expression = gets.chomp

puts "RPN expression: #{to_rpn(expression)}"
