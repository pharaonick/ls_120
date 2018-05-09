# class SecretFile
#   def initialize(secret_data, security_log_obj)
#     @data = secret_data
#     @log = security_log_obj
#   end

#   def data
#     @log.create_log_entry
#     @data
#   end
# end
# # modify so any access to `data` must result in log entry being generated.
# # must first call a logging class
# # use this class

# # (note log could be a new or extant instance)
# # (also note I named this to be clear to me what is going on, rather
# # than the most appropriate name approach)

# class SecurityLogger
#   def create_log_entry
#     # ... implementation omitted ...
#   end
# end

#-------------------------------------------------------------------

# module FuelData
#   def set_fuel_data(km_traveled_per_liter, liters_of_fuel_capacity)
#     @fuel_efficiency = km_traveled_per_liter
#     @fuel_capacity = liters_of_fuel_capacity
#   end

#   def range
#     @fuel_capacity * @fuel_efficiency
#   end
# end

# class WheeledVehicle
#   include FuelData
#   attr_accessor :speed, :heading

#   def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
#     @tires = tire_array
#     set_fuel_data(km_traveled_per_liter, liters_of_fuel_capacity)
#   end

#   def tire_pressure(tire_index)
#     @tires[tire_index]
#   end

#   def inflate_tire(tire_index, pressure)
#     @tires[tire_index] = pressure
#   end
# end

# class Auto < WheeledVehicle
#   def initialize
#     # 4 tires are various tire pressures
#     super([30,30,32,32], 50, 25.0)
#   end
# end

# class Motorcycle < WheeledVehicle
#   def initialize
#     # 2 tires are various tire pressures
#     super([20,20], 80, 8.0)
#   end
# end

# class Catamaran
#   include FuelData
#   attr_accessor :propeller_count, :hull_count, :speed, :heading

#   def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
#     set_fuel_data(km_traveled_per_liter, liters_of_fuel_capacity)
#     # ... other code omitted ...
#   end
# end

# car = Auto.new
# cycle = Motorcycle.new
# cat = Catamaran.new(4, 2, 25, 50)

# # p car
# # p cycle
# # p cat
# p cat.range

# # BETTER SOLUTION IS TO MAKE THE MODULE BROADER
# module Moveable
#   attr_accessor :speed, :heading
#   attr_writer :fuel_efficiency, :fuel_capacity

#   def range
#     @fuel_capacity * @fuel_efficiency
#   end
# end

# class WheeledVehicle
#   include Moveable

#   def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
#     self.fuel_efficiency = km_traveled_per_liter
#     self.fuel_capacity = liters_of_fuel_capacity
#     @tires = tire_array
#   end

#   def tire_pressure(tire_index)
#     @tires[tire_index]
#   end

#   def inflate_tire(tire_index, pressure)
#     @tires[tire_index] = pressure
#   end
# end

# class Auto < WheeledVehicle
#   def initialize
#     # 4 tires are various tire pressures
#     super([30,30,32,32], 50, 25.0)
#   end
# end

# class Motorcycle < WheeledVehicle
#   def initialize
#     # 2 tires are various tire pressures
#     super([20,20], 80, 8.0)
#   end
# end

# class Catamaran
#   include Moveable
#   attr_accessor :propeller_count, :hull_count

#   def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
#     self.fuel_efficiency = km_traveled_per_liter
#     self.fuel_capacity = liters_of_fuel_capacity
#     # ... other code omitted ...
#   end
# end

#-------------------------------------------------------------------
# Add Motorboat...
# module Moveable
#   attr_accessor :speed, :heading
#   attr_writer :fuel_efficiency, :fuel_capacity

#   def range
#     @fuel_capacity * @fuel_efficiency
#   end
# end

# class WheeledVehicle
#   include Moveable

#   def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
#     self.fuel_efficiency = km_traveled_per_liter
#     self.fuel_capacity = liters_of_fuel_capacity
#     @tires = tire_array
#   end

#   def tire_pressure(tire_index)
#     @tires[tire_index]
#   end

#   def inflate_tire(tire_index, pressure)
#     @tires[tire_index] = pressure
#   end
# end

# class Auto < WheeledVehicle
#   def initialize
#     # 4 tires are various tire pressures
#     super([30,30,32,32], 50, 25.0)
#   end
# end

# class Motorcycle < WheeledVehicle
#   def initialize
#     # 2 tires are various tire pressures
#     super([20,20], 80, 8.0)
#   end
# end

# class Catamaran
#   include Moveable
#   attr_accessor :propeller_count, :hull_count

#   def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
#     self.fuel_efficiency = km_traveled_per_liter
#     self.fuel_capacity = liters_of_fuel_capacity
#     self.propeller_count = num_propellers
#     self.hull_count = num_hulls
#   end
# end

# class Motorboat < Catamaran
#   def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
#     super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
#   end
# end

# boat = Motorboat.new(100, 4)
# p boat

# # AGAIN, BETTER WAY TO DO THIS THAT HAS A MORE NATURAL RELATIONSHIP
# # BETWEEN MOTORBOAT AND CATAMARAN, SINCE A MOTORBOAT IS NOT A TYPE OF CAT

# module Moveable
#   attr_accessor :speed, :heading
#   attr_writer :fuel_efficiency, :fuel_capacity

#   def range
#     @fuel_capacity * @fuel_efficiency
#   end
# end

# class WheeledVehicle
#   include Moveable

#   def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
#     self.fuel_efficiency = km_traveled_per_liter
#     self.fuel_capacity = liters_of_fuel_capacity
#     @tires = tire_array
#   end

#   def tire_pressure(tire_index)
#     @tires[tire_index]
#   end

#   def inflate_tire(tire_index, pressure)
#     @tires[tire_index] = pressure
#   end
# end

# class Auto < WheeledVehicle
#   def initialize
#     # 4 tires are various tire pressures
#     super([30,30,32,32], 50, 25.0)
#   end
# end

# class Motorcycle < WheeledVehicle
#   def initialize
#     # 2 tires are various tire pressures
#     super([20,20], 80, 8.0)
#   end
# end

# class SeaVessel
#   include Moveable
  
#   attr_accessor :propeller_count, :hull_count

#   def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
#     self.fuel_efficiency = km_traveled_per_liter
#     self.fuel_capacity = liters_of_fuel_capacity
#     self.propeller_count = num_propellers
#     self.hull_count = num_hulls
#   end
# end

# # no need to specify an initialize method since all we want is to call the 
# # init from SeaVessel exactly as-is. When the Cat class is instantiated, Ruby
# # will automatically execute an initialize method if there is one, and will
# # traverse the class hierarchy to find it.
# class Catamaran < SeaVessel; end

# # # If you were going to write it out it would look like this:
# # class Catamaran < SeaVessel
# #   def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
# #     super # no need for args here since we are passing all of them
# #   end
# # end

# class Motorboat < SeaVessel
#   def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
#     super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
#   end
# end

#-------------------------------------------------------------------
# adjust range of sea vehicles

module Moveable
  attr_accessor :speed, :heading
  attr_writer :fuel_efficiency, :fuel_capacity

  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class WheeledVehicle
  include Moveable

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
    @tires = tire_array
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
end

class Auto < WheeledVehicle
  def initialize
    # 4 tires are various tire pressures
    super([30,30,32,32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  def initialize
    # 2 tires are various tire pressures
    super([20,20], 80, 8.0)
  end
end

class SeaVessel
  include Moveable
  
  attr_accessor :propeller_count, :hull_count

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
    self.propeller_count = num_propellers
    self.hull_count = num_hulls
  end

  def range
    super + 10
  end
end

class Catamaran < SeaVessel; end

class Motorboat < SeaVessel
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end

cat = Catamaran.new(4, 2, 20, 10)
p cat.range
