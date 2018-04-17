module CrushSmallerVehicle
  
  def crush_it?(size)
    size == 'smaller' ? true : false
  end

end

class Vehicle

  attr_accessor :color, :current_speed
  attr_reader :year, :model
  @@number_of_vehicles = 0

  def self.output_current_number_of_vehicles
    puts "There are currently #{@@number_of_vehicles} vehicles knocking around..."
  end

  def self.mileage(miles, gallons)
    puts "#{miles / gallons} miles per gallon."
  end

  # can allow speed as argument that defaults to 0 if you want, like in a normal method
  def initialize(color, year, model)
    self.color = color
    @year = year # can't call self here because haven't defined setter method for year
    @model = model
    self.current_speed = 0
    @@number_of_vehicles += 1
    puts "Sweet #{self.color} #{self.year} #{self.model} bro!"
  end

  def output_current_speed
    puts "Your current speed is #{current_speed} mph."
  end

  # NOTE THIS METHOD IS DOING TWO THINGS WHICH IS NOT IDEAL...
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
    puts "YIIISSSSSSS! You spray your vehicle #{self.color}!!"
  end

  def age
    puts "Your #{self.model} is #{calculate_age} years old!" # note use of `self` because it's an instance of MyCar so we can access its model
  end

  private
  def calculate_age
    t = Time.new
    t.year - @year.to_i # more efficient to write as `Time.now.year`
  end

end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
  
  def to_s
    "My car is a #{self.color} #{self.year} #{self.model}."
  end

end

class MyTruck < Vehicle
  include CrushSmallerVehicle

  NUMBER_OF_DOORS = 2

  def to_s
    "My truck is a #{self.color} #{self.year} #{self.model}."
  end

  def spray_paint(new_color)
    super
    puts "Remember it's actually a truck though..."
  end

end

fast_car = MyCar.new('lime green', '1963', 'triumph')
# fast_car.speed_up(250)

# big_truck = MyTruck.new('jet black', '2010', 'BIGBOY')
# big_truck.spray_paint('wholesome lime')
# big_truck.output_current_speed

# Vehicle.output_current_number_of_vehicles

# faster_car = MyCar.new('red', '2019', 'muskian')
# Vehicle.output_current_number_of_vehicles

# puts "You crushed that puny thing" if big_truck.crush_it?('smaller')

# puts "The MyCar class method lookup is: #{MyCar.ancestors}"
# puts "The MyTruck class method lookup is: #{MyTruck.ancestors}"
# puts "The Vehicle class method lookup is: #{Vehicle.ancestors}"

fast_car.age
