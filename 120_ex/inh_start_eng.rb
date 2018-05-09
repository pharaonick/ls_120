class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end
end

class Truck < Vehicle
  def initialize(year)
    super(year) # param not needed here because invoking super without parentheses passes all arguments up the chain
    start_engine
  end

  def start_engine
    puts 'Ready to go!'
  end
end
