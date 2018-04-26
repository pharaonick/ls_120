puts "Top Level"
puts "self is #{self}"

class C
  puts "Class definition block:"
  puts "self is #{self}"

  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def self.x
    puts "Class method C.x:"
    puts "self is #{self}"
  end

  # def to_s
  #   @name
  # end

  def m
    puts "Instance method C#m:"
    puts "self is #{self}"
  end
end

C.x
C.new('Cool Instance Name').m
# my_c = C.new
