class Vehicle
  @@wheels = 4

  def self.wheels
    @@wheels
  end
end

p Vehicle.wheels #=> 4

class Motorcycle < Vehicle
  @@wheels = 2
end

p Motorcycle.wheels #=> 2
p Vehicle.wheels #=> 2 OOPS

class Car < Vehicle
end

p Car.wheels #=> 2

class Car < Vehicle
  @@wheels = 'many!'
end

p Motorcycle.wheels #=> 'many!'
p Vehicle.wheels #=> 'many!'
p Car.wheels #=> 'many!'