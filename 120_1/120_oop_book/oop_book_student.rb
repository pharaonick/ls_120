# Create a class 'Student' with attributes name and grade. 
# Do NOT make the grade getter public, so joe.grade will raise an error. 
# Create a better_grade_than? method, that you can call like so...

# puts "Well done!" if joe.better_grade_than?(bob)



class Student
  attr_accessor :name

  # I think you would want to be consistent in how you define, this was more to experiment
  def initialize(name, grade)
    self.name = name
    @grade = grade
  end

  def better_grade_than?(student)
    grade > student.grade
  end

  protected # private throws an error because having to call second grade using student, which is a separate instantiation ????????
  
  def grade
    @grade
  end

  # not using this anywhere...
  # def grade=(grade)
  #   @grade = grade
  # end

end

joe = Student.new('Joe', 88)
bob = Student.new('Bob', 67)

puts joe.better_grade_than?(bob) ? "Joe has a higher grade" : "Joe tanked man"


# public interface to access private method
# e.g. if want to perform some kind of check first

class Person

  def public_hi
    hi if 'call private `hi` if some condition is met'
  end

  private

  def hi
    puts 'hi'
  end

end

bob = Person.new
bob.hi # => error... private method `hi` called...
bob.public_hi # => 'hi'





