class Person
  # attr_reader :name

  def initialize(name)
    @name = name
  end

  def name
    @name.dup # or clone
  end
end

person1 = Person.new('James')
person1.name.reverse!
puts person1.name # 'James'