# class House
#   attr_reader :price

#   def initialize(price)
#     @price = price
#   end
# end

# home1 = House.new(100_000)
# home2 = House.new(150_000)
# puts "Home 1 is cheaper" if home1 < home2
# puts "Home 2 is more expensive" if home2 > home1

# output
# Home 1 is cheaper
# Home 2 is more expensive

# make it work, can define only one new method in `House`

class House
  include Comparable

  attr_reader :price

  def initialize(price)
    @price = price
  end

  # def <=>(other)
  #   price <=> other.price
  # end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2 # 'Home 1 is cheaper'
puts "Home 2 is more expensive" if home2 > home1 # 'Home 2 is more expensive'

# might be better to do this in some ways (then don't need custom `<=>`):
# puts "Home 1 is cheaper" if home1.price < home2.price # 'Home 1 is cheaper'
# puts "Home 2 is more expensive" if home2.price > home1.price # 'Home 2 is more expensive'