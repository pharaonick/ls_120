class Pet
  def initialize(name, age)
    @name = name
    @age = age
  end

  def to_s
    "My #{self.class.name.downcase} #{@name} is #{@age} years old."
  end
end

class Cat < Pet
  def initialize(name, age, color)
    super(name, age)
    @color = color
  end

  def to_s
    "#{super.chop} and has #{@color} fur."
  end
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch

# My cat Pudding is 7 years old and has black and white fur.
# My cat Butterscotch is 10 years old and has tan and white fur.

# (also note that you didn't have to write `to_s` in `Pet`...)
# alternative is to modify `Pet#initialize`
# problems - now all pets are going to have color whether we want it or not
           # - that @color is set to nil by default, which seems kinda weird
           # - surely best to customize `Cat` directly, keeps things more flexible for future

class Pet
  def initialize(name, age, color = nil)
    @name = name
    @age = age
    @color = color
  end

  def to_s
    "My #{self.class.name.downcase} #{@name} is #{@age} years old."
  end
end

class Cat < Pet
  def to_s
    "#{super.chop} and has #{@color} fur."
  end
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch