# class Expander
#   def initialize(string)
#     @string = string
#   end

#   def to_s
#     self.expand(3)
#   end

#   private

#   def expand(n)
#     @string * n
#   end
# end

# expander = Expander.new('xyz')
# puts expander

class Expander
  def initialize(string)
    @string = string
  end

  def to_s
    expand(3) # or keep `self` and change `privat` to `protected`
  end

  private

  def expand(n)
    @string * n
  end
end

expander = Expander.new('xyz')
puts expander