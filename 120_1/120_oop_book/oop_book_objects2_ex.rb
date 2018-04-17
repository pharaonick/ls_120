# (also defined getter/setter for `current_speed`)
class MyCar

  attr_accessor :color, :current_speed
  attr_reader :year, :model

  # WHERE DO WE PLACE CLASS METHODS IN THE CLASS DEFINITION?
  def self.mileage(miles, gallons)
    puts "#{miles / gallons} miles per gallon."
  end

  def initialize(color, year, model)
    @color = color
    @year = year
    @model = model
    @current_speed = 0
    puts "Sweet #{self.color} #{self.year} #{self.model} bro!"
  end

  def to_s
    "This is a #{self.color} #{self.year} #{self.model}."
  end

  def output_current_speed
    puts "Your current speed is #{current_speed} mph."
  end

  def speed_up(incr)
    self.current_speed += incr
    puts "You speed up by #{incr} mph. Weeeeeeeee!"
  end

  def slow_down(decr)
    self.current_speed -= decr
    puts "You slow down by #{decr} mph. Booooooooo!"
  end 

  def park
    self.current_speed = 0
    puts "For some weird reason you decide to park..."
  end

  def spray_paint(new_color)
    self.color = new_color
    puts "YIIISSSSSSS! You spray your car #{self.color}!!"
  end

end

# MyCar.mileage(130, 10)

geezer = MyCar.new('lime green', '\'63', 'triumph')
# geezer.to_s
puts geezer



