class Pet
  def swim
    'swimming!'
  end

  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Pet
  def speak
    'bark!'
  end

  def fetch
    'fetching!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

class Cat < Pet
  def speak
    'meow'
  end

  def swim
    'lol no swimming i not bengal'
  end
end

class Person
  attr_accessor :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end
end

bob = Person.new("Robert")
kitty = Cat.new
bud = Bulldog.new

bob.pets << kitty
bob.pets << bud
bob.pets # => [#<Cat:bloah>, #<Bulldog:bleeeggh>]

bob.pets.jump # => undefined method (calling Pet instance method on array...)

bob.pets.each do |pet|
  pet.jump
end