# Абстракція визначає інтерфейс для частини "контролю" в ієрархіях двох класів.
# Вона містить посилання на об'єкт з ієрархії Реалізацій і делегує всю
# реальну роботу цьому об'єкту.
class Abstraction
  # @param [Implementation] implementation
  def initialize(implementation)
    @implementation = implementation
  end

  # @return [String]
  def operation
    "Abstraction: Базова операція з:\n"\
      "#{@implementation.operation_implementation}"
  end
end

# Ви можете розширювати Абстракцію, не змінюючи класи Реалізацій.
class ExtendedAbstraction < Abstraction
  # @return [String]
  def operation
    "ExtendedAbstraction: Розширена операція з:\n"\
      "#{@implementation.operation_implementation}"
  end
end

# Реалізація визначає інтерфейс для всіх класів реалізацій. Вона
# не обов'язково повинна відповідати інтерфейсу Абстракції. Насправді, ці два інтерфейси
# можуть бути повністю різними. Зазвичай, інтерфейс Реалізації надає
# лише примітивні операції, тоді як Абстракція визначає вищий рівень
# операцій на основі цих примітивів.
class Implementation
  # @abstract
  #
  # @return [String]
  def operation_implementation
    raise NotImplementedError, "#{self.class} не реалізував метод '#{__method__}'"
  end
end

# Кожна Конкретна Реалізація відповідає певній платформі та реалізує
# інтерфейс Реалізації за допомогою API цієї платформи.
class ConcreteImplementationA < Implementation
  # @return [String]
  def operation_implementation
    'ConcreteImplementationA: Ось результат на платформі A.'
  end
end

class ConcreteImplementationB < Implementation
  # @return [String]
  def operation_implementation
    'ConcreteImplementationB: Ось результат на платформі B.'
  end
end

# За винятком етапу ініціалізації, коли об'єкт Абстракції пов'язується
# з конкретним об'єктом Реалізації, код клієнта повинен залежати лише від
# класу Абстракції. Таким чином, код клієнта може підтримувати будь-яку комбінацію
# абстракції та реалізації.
def client_code(abstraction)
  # ...

  print abstraction.operation

  # ...
end

# Код клієнта повинен бути здатним працювати з будь-якою попередньо налаштованою комбінацією
# абстракції та реалізації.

implementation = ConcreteImplementationA.new
abstraction = Abstraction.new(implementation)
client_code(abstraction)

puts "\n\n"

implementation = ConcreteImplementationB.new
abstraction = ExtendedAbstraction.new(implementation)
client_code(abstraction)
