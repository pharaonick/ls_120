# #1
# class Person
#   attr_accessor :name

#   def initialize(name)
#     self.name = name # might be easier just to do as @name = name
#   end
# end

# bob = Person.new('bob')
# bob.name                  # => 'bob'
# bob.name = 'Robert'
# bob.name                  # => 'Robert'

####################

# #2
# class Person
#   attr_accessor :first_name, :last_name

#   def initialize(full_name)
#     names = full_name.split
#     self.first_name = names.first
#     self.last_name = names.size > 1 ? names.last : ''
#   end

#   def name
#     "#{first_name} #{last_name}".strip
#   end
# end

# bob = Person.new('Robert')
# bob.name                  # => 'Robert'
# bob.first_name            # => 'Robert'
# bob.last_name             # => ''
# bob.last_name = 'Smith'
# bob.name                  # => 'Robert Smith'

####################

# #3
# # create smart `name=` method that can take just a first name or a full name
# # and knows how to set `first_name` and `last_name` appropriately

# class Person
#   attr_accessor :first_name, :last_name

#   def initialize(full_name)
#     names = full_name.split
#     self.first_name = names.first
#     self.last_name = names.size > 1 ? names.last : ''
#   end

#   def name
#     "#{first_name} #{last_name}".strip
#   end

#   def name=(full_name)
#     names = full_name.split
#     self.first_name = names.first
#     self.last_name = names.size > 1 ? names.last : ''
#   end
# end


# REFACTOR TO MAKE DRY, CAN BE MADE PRIVATE BECAUSE NOT USED OUTSIDE CLASS DEF
# give thought to how to name the variables and methods
# e.g. `parse_full_name` might be a better method name
# and keeping `full_name` as the params for the `init` and `name=` methods


# class Person
#   attr_accessor :first_name, :last_name

#   def initialize(name)
#     split_names(name)
#   end

#   def name
#     "#{first_name} #{last_name}".strip
#   end

#   def name=(name)
#     split_names(name)
#   end

#   private

#   def split_names(full_name)
#     names = full_name.split
#     self.first_name = names.first
#     self.last_name = names.size > 1 ? names.last : ''
#   end
# end


# bob = Person.new('Robert')
# bob.name                  # => 'Robert'
# bob.first_name            # => 'Robert'
# bob.last_name             # => ''
# bob.last_name = 'Smith'
# bob.name                  # => 'Robert Smith'

# bob.name = "John Adams"
# bob.first_name            # => 'John'
# bob.last_name             # => 'Adams'

####################

# #4
# class Person
#   attr_accessor :first_name, :last_name

#   def initialize(full_name)
#     parse_full_name(full_name)
#   end

#   def name
#     "#{first_name} #{last_name}".strip
#   end

#   def name=(full_name)
#     parse_full_name(full_name)
#   end

#   private

#   def parse_full_name(full_name)
#     parts = full_name.split
#     self.first_name = parts.first
#     self.last_name = parts.size > 1 ? parts.last : ''
#   end
# end

# bob = Person.new('Robert Smith')
# rob = Person.new('Robert Smith')

# # If we're trying to determine whether the two objects contain the same name, 
# # how can we compare the two objects?

# bob.name.split.each do |name|
#   puts 'true' if rob.name.split.include?(name)
# end

# # Seem to want to see if names are exactly the same...
# # in which case

# bob.name == rob.name

# NOTE
# we are comparing two String objects, so why can't we directly compare
# two Person objects? We can't... answers TK

####################

#5
class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parse_full_name(full_name)
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(full_name)
    parse_full_name(full_name)
  end

  private

  def parse_full_name(full_name)
    parts = full_name.split
    self.first_name = parts.first
    self.last_name = parts.size > 1 ? parts.last : ''
  end
end

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"
# no `to_s` defined so get the standard class + objectID encoding
# To get around this, either define a custom `to_s` 
def to_s
  name
end
#or:
puts "The person's name is: " + bob.name







