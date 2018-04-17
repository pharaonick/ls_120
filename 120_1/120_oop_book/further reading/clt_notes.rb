# self

cookie = Object.new

def cookie.add_chips(num_chips)
  @chips = num_chips
end

def cookie.yummy?
  @chips > 100
end

cookie.add_chips(500)
cookie.yummy?   #=> true

def cookie.add_chips(num_chips = 10)
  @chips 
  @chips += num_chips
end

def cookie.yummify
  add_chips until yummy?
end

# inside yummify the call to yummy? goes to self

####################################

#inheritance example
class Rectangle
  def initialize(width, height)
    @width, @height = width, height
  end
  def area
    @width * @height
  end
end

class Square < Rectangle
  def initialize(width)
    super(width, width)
  end
end

Square.new(10).area #=> 100

####################################

# Class methods
# as factories

class Person
  def self.from_string(s)
    tokens = s.split    
    new(tokens[0], tokens[1], tokens[2].to_i) # Class#new method -> object
  end

  def initialize(first, last, age)
    @first, @last, @age = first, last, age
  end
end

alice = Person.new("Alice", "Andrews", 17)
#=> #<Person:0x000001009eca90 
#   @first="Alice", @last="Andrews", @age=17>

bob = Person.from_string("Bob Barker 67")
#=> #<Person:0x000001009e3af8 
#   @first="Bob", @last="Barker", @age=67>