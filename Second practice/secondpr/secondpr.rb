class RPNConverter
  OPERATORS = {
    '+' => 1,
    '-' => 1,
    '*' => 2,
    '/' => 2
  }

  def initialize(expression)
    @expression = expression
  end

  def back_to_rpn
    output = []
    stack = []
    tokens = tokenize(@expression)

    tokens.each do |token|
      if number?(token)
        output << token
      elsif operator?(token)
        while stack.any? && precedence(stack.last) >= precedence(token)
          output << stack.pop
        end
        stack << token
      elsif token == '('
        stack << token
      elsif token == ')'
        while stack.any? && stack.last != '('
          output << stack.pop
        end
        stack.pop
      end
    end

    while stack.any?
      raise 'Неправильний вираз: зайві операнди' if stack.last == '(' || stack.last == ')'
      output << stack.pop
    end

    output.join(' ')
  end

  private

  def tokenize(expression)
    expression.gsub(/(\d+(\.\d+)?)|[+\-*\/()]/) { |match| " #{match} " }.split
  end

  def number?(token)
    token.match?(/\A-?\d+(\.\d+)?\z/)
  end

  def operator?(token)
    OPERATORS.key?(token)
  end

  def precedence(operator)
    OPERATORS[operator] || 0
  end
end

# Приклад використання
expression = "2 + 1 * 4"
converter = RPNConverter.new(expression)
rpn = converter.back_to_rpn
puts "RPN: #{rpn}"
