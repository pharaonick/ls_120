class Cat
  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end
end

Cat.generic_greeting # "Hello! I'm a cat!"

kitty = Cat.new
kitty.generic_greeting # => undefined method
kitty.class.generic_greeting # "Hello! I'm a cat!" 
# - because Object#class returns class of object
# - i.e. in this case, Cat




