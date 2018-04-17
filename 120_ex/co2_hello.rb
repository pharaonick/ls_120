# class Cat
#   attr_accessor :name

#   def initialize(name)
#     @name = name
#   end

#   def rename(new_name)
#     self.name = new_name
#   end

#   def identify
#     self
#   end
# end

# kitty = Cat.new('Sophie')
# p kitty.identify
# puts kitty.identify
# kitty.name
# kitty.rename('Chloe')
# kitty.name

############################

# class Cat
#   attr_reader :name

#   def initialize(name)
#     @name = name
#   end

#   def self.generic_greeting
#     puts "Hello! I'm a cat!"
#   end

#   def personal_greeting
#     puts "Hello! My name is #{name}!"
#   end
# end

# kitty = Cat.new('Sophie')

# Cat.generic_greeting # => Hello! I'm a cat!
# kitty.personal_greeting # => Hello! My name is Sophie!

############################

# class Cat
#   @@total_cats = 0

#   def initialize
#     @@total_cats += 1
#   end

#   def self.total
#     puts @@total_cats
#   end
# end


# kitty1 = Cat.new
# kitty2 = Cat.new

# Cat.total

############################

class Cat
  COLOR = 'purple'
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def greet
    puts "Hello! My name is #{@name} and I'm a #{COLOR} cat!"
  end

  def to_s
    "I'm #{name}!"
  end

end


kitty = Cat.new('Sophie')
kitty.greet # Hello! My name is Sophie and I'm a purple cat!
puts kitty























