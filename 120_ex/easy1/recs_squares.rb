class Rectangle
  def initialize(height, width)
    @height = height
    @width = width
  end

  def area
    @height * @width
  end
end

class Square < Rectangle
  # def initialize(length)
  #   @height = length
  #   @width = length
  # end

  # better? yes, in case we change the ivar names or anything like that, 
  # or extend the Rectangel init somehow...
  def initialize(length)
    super(length, length)
  end

  # sexier...
  def initialize(height, width = height)
    super
  end
end

square = Square.new(5)
puts "area of square = #{square.area}"