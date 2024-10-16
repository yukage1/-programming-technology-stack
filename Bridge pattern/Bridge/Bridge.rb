# Абстракція
class Animal
  def initialize(sound)
    @sound = sound
  end

  def make_sound
    @sound.make_sound
  end
end

# Реалізація звуків
class Roar
  def make_sound
    "Рррр!"
  end
end

class Meow
  def make_sound
    "Мяу!"
  end
end

class Bark
  def make_sound
    "Гав!"
  end
end

# Конкретні тварини, які використовують реалізацію звуку
class Lion < Animal
  def initialize
    super(Roar.new)
  end
end

class Cat < Animal
  def initialize
    super(Meow.new)
  end
end

class Dog < Animal
  def initialize
    super(Bark.new)
  end
end

# Використання

lion = Lion.new
# Виведе: "Рррр!"
puts lion.make_sound

# Виведе: "Мяу!"
cat = Cat.new
puts cat.make_sound

# Виведе: "Гав!"
dog = Dog.new
puts dog.make_sound
