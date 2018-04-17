class Parent
  def initialize
    puts "hi i got created"
  end
end

class Baby < Parent
  # the constructor gets called without needing `super`
end

bubble = Baby.new

# ---------- #

# PRIVATE
class Some
    
    def initialize
        method1
        # self.method1 -- private method cannot be called with self
    end

    private
    
     def method1
         puts "private method1 called"  
     end
           
end


s = Some.new # => 'private method 1 called' -- method is called from within class def during inti of obj
s.method1 # => error, because cannot call private method outside of class def


#PROTECTED
class Some
    
    def initialize
        method1
        self.method1 # protected methods can be called with self
    end

    protected
    
     def method1
         puts "protected method1 called"  
     end
           
end


s = Some.new # => "protected method1 called" "protected method1 called" 
s.method1 # protected methods cannot be called outside of class

# ---------- #

# SUPER

class Base
   
    def show x=0, y=0
        p "Base class, x: #{x}, y: #{y}"
    end
end

class Derived < Base

    def show x, y
        super
        super x
        super x, y
        super()
    end
end


d = Derived.new
d.show(3, 4)
# => 3, 4 | 3, 0 | 3, 4 | 0, 0


class Parent
  def initialize
    puts "parenting"
  end
end

class Child < Parent
  # w/e
end

class Grandchild < Child
  def initialize
    super
  end
end

gc = Grandchild.new # => 'parenting'


# ---------- #

#OPERATORS

class Circle
   
    attr_accessor :radius
    
    def initialize r
        @radius = r
    end

    def +(other)
        Circle.new @radius + other.radius
    end
    
    def to_s
        "Circle with radius: #{@radius}"
    end
end


c1 = Circle.new 5
c2 = Circle.new 6
c3 = c1 + c2 # `+` is being called on `c1` with `c2` passed as arg
             # meaning a new Circle is being created with radius
             # c1 radius (@radius) + c2 radius (c2.radius)

p c3

# ---------- #
# 3 WAYS TO CREATE CLASS METHOD

class Wood
  def self.info
    "This is a Wood class"
  end
end

class Brick
  class << self
    def info
      "This is a Brick class"
    end
  end
end

class Rock; end
def Rock.info
  "This is a Rock class"
end

# ---------- #
# 3 WAYS TO CREATE INSTANCE METHOD

class Wood
  def info
    "This is a Wood object"
  end
end
w = Wood.new
p w.info

class Brick
  attr_accessor :info
end
b = Brick.new
b.info = "This is a Brick object"
p b.info

class Rock; end
r = Rock.new
def r.info
  "This is a Rock object"
end
p r.info

# ---------- #
# INHERITANCE AND BTW CHAINING!!!
class Animal
    
    def make_noise 
        "Some noise"
    end

    def sleep 
        puts "#{self.class.name} is sleeping." # not sure this needs `name`??
    end
  
end

class Dog < Animal
    
    def make_noise 
        'Woof!'         
    end 
    
end

class Cat < Animal 
    
    def make_noise 
        'Meow!' 
    end 
end

# note how we instantiate objects but just don't store them!
[Animal.new, Dog.new, Cat.new].each do |animal|
  puts animal.make_noise
  animal.sleep
end
