# (also defined getter/setter for `current_speed`)
class MyCar

  attr_accessor :color, :current_speed
  attr_reader :year, :model

  def initialize(color, year, model)
    @color = color
    @year = year
    @model = model
    @current_speed = 0
    puts "Sweet #{self.color} #{self.year} #{self.model} bro!"
  end

  # can't name this method using same name as the instance var!
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

herbie = MyCar.new('blue', '2000', 'lovebug')
p herbie.color
p herbie.year
p herbie.model
herbie.output_current_speed
puts "Let's go for a ride..."
puts "########################"
herbie.speed_up(100)
herbie.output_current_speed
herbie.slow_down(40)
herbie.output_current_speed
herbie.park
herbie.output_current_speed
puts "Now let's mod ..."
puts "########################"
herbie.spray_paint('invisible amiright')




