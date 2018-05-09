# class Greeting
#   def greet(string)
#     puts string
#   end
# end

# class Hello < Greeting
#   def hi
#     greet("Hello.")
#   end
# end

# class Goodbye < Greeting
#   def bye
#     greet("Goodbye.")
#   end
# end

#----------------------------------------------------------------------------

class KrispyKreme
  def initialize(filling_type, glazing)
    @glazing = glazing
    @filling_type = filling_type == nil ? 'Plain' : filling_type
  end

  def to_s
    @glazing == nil ? "#{@filling_type}" : "#{@filling_type} with #{@glazing}"
  end
end

# MORE IDIOMATIC...**************************************************
class KrispyKreme
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end

  def to_s
    filling_string = @filling_type ? @filling_type : "Plain" # *********
    glazing_string = @glazing ? " with #{@glazing}" : ""
    filling_string + glazing_string
  end
end

donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1
  #=> "Plain"

puts donut2
  #=> "Vanilla"

puts donut3
  #=> "Plain with sugar"

puts donut4
  #=> "Plain with chocolate sprinkles"

puts donut5
  #=> "Custard with icing"

#----------------------------------------------------------------------------
class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end

# how is ^ different to:
class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    self.template
  end
end