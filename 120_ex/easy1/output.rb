# class Pet
#   attr_reader :name

#   def initialize(name)
#     @name = name.to_s # NOT the modified `Pet#to_s` 
#   end

#   def to_s
#     @name.upcase!
#     "My name is #{@name}."
#   end
# end

# name = 'Fluffy'
# fluffy = Pet.new(name)
# puts fluffy.name # 'Fluffy'
# puts fluffy # 'My name is FLUFFY'
# puts fluffy.name # 'FLUFFY'
# puts name # 'FLUFFY' ### THIS IS KEY... `name` and `@name` POINTING TO SAME OBJ IN MEMORY

#FIX IT
class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s # this `to_s` is only needed for the further exploration
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name # 'Fluffy'
puts fluffy # 'My name is FLUFFY'
puts fluffy.name # 'Fluffy'
puts name # 'Fluffy'

# further exploration, what happens here and why?
name = 42
fluffy = Pet.new(name)
name += 1 # here we reassign the `name` local variable so it is no longer pointing at the same object as the `@name` ivar in the `Pet` object
          # and besides, we set `@name` to a string anyway on line 26, not to an integer
puts fluffy.name # '42'
puts fluffy # "My name is 42"
puts fluffy.name # '42'
puts name # '43'