class Person
  def name=(names)
    # @first = names.split.first
    # @last = names.split.last
    @first, @last = names.split # this is cleaner!
  end

  def name
    @first + ' ' + @last
  end
end

person1 = Person.new
person1.name = 'John Doe'
puts person1.name # 'John Doe'