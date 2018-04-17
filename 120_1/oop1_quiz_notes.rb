=begin

Language: 
Cow inherits #speak from Animal. 
When daisy calls #speak, it calls #sound and passes the return value to puts. 
***** Since an instance of Cow calls #speak, #speak calls Cow#sound. *****
Cow#sound uses super to call Animal#sound, 
  which returns the interpolated string "Daisy says ". 
Cow#sound then concatenates the return value with the string "moooooooooooo!" 
  and returns the new result, which is output by puts.

=end

class Animal
  def initialize(name)
    @name = name
  end

  def speak
    puts sound
  end

  def sound
    "#{@name} says "
  end
end

class Cow < Animal
  def sound
    super + "moooooooooooo!"
  end
end

daisy = Cow.new("Daisy")
daisy.speak

###########
# general rule is that `self` outside of an imethod references the class
class MeMyselfAndI
  self # -> class

  def self.me # -> class
    self # -> class
  end

  def myself
    self # -> object
  end
end

i = MeMyselfAndI.new


###########
class SecretThing

  def share_secret
    "The secret is #{self.secret}"
  end

  private

  def secret
    "shhh.. it's a secret!!"
  end
end

SecretThing.new.share_secret # => error - cannot call private method with receiver
# change `secret` method to protected (or public), or
# call the private method without `self`

###########
# Couple thoughts on to_s inspired by Tannr's thread... nothing to do with quiz
class MyCar
    attr_accessor :color
    attr_reader :year

    def initialize(year, color, model, speed = 0)
        @year = year
        @color = color
        @model = model
        @speed = speed
    end

    def to_s
        "My car is a #{color}, #{year}, #{@model}!"
    end

    def self.mileage(miles, gallons)
        puts "Mileage is #{miles / gallons}"
    end

    def output_test
      puts "hi I'm testing if to_s is called on a string"
    end

    # def self.to_s
    #   "Now I've overridden to_s for the class too..."
    # end

    def self.testing_to_s
      puts self
    end
end 

my_car = MyCar.new('1990', 'red', 'Jag')
puts my_car # custom to_s called
my_car.output_test # normal puts because don't need to call to_s on string
puts "hi" # normal puts output - not an instance of MyCar anyway
MyCar.testing_to_s # MyCar because custom to_s defined for instances of class not class itself
  # if you allows the class to_s override then you get a different output!!












