# module Speed
#   def go_fast
#     puts "I am a #{self.class} and going super fast!"
#   end
# end

# class Car
#   include Speed
#   def go_slow
#     puts "I am safe and driving slow."
#   end
# end

# ----------------------------------

# class Fruit
#   def initialize(name)
#     name = name
#   end
# end

# class Pizza
#   def initialize(name)
#     @name = name
#     @cheese_rating = 11
#   end
# end

# fruit = Fruit.new('fruity')
# pizza = Pizza.new('cheesy')
# p fruit
# p pizza
# puts fruit.instance_variables
# puts pizza.instance_variables

# ----------------------------------

# class Greeting
#   def greet(message)
#     puts message
#   end

#   def self.hi
#     puts 'HI'
#   end
#   # OR
#   def self.hi2
#     greeting = Greeting.new # can't just call `greet` directly because it's an instance method
#     greeting.greet("Hello")
#   end

# end

# class Hello < Greeting
#   def hi
#     greet("Hello")
#   end
# end

# class Goodbye < Greeting
#   def bye
#     greet("Goodbye")
#   end
# end

# # hello = Hello.new
# # hello.hi # Hello

# # hello = Hello.new
# # hello.bye # undefined method error

# # hello = Hello.new
# # hello.greet # wrong arguments error

# # hello = Hello.new
# # hello.greet("Goodbye") # Goodbye

# Hello.hi # undefined method error

# ----------------------------------

# sometimes better to write a `display_type` method rather than override `to_s`
class Cat
  def initialize(type)
    @type = type
  end

  def to_s
    "I am a #{@type} cat."
  end
end


