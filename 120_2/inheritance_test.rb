class Parent
  attr_accessor :name, :age

  def initialize(name)
    @name = name
  end
end

class Child < Parent
  attr_accessor :test
  def initialize(name)
    self.name = name
    @test = 42
  end
end

