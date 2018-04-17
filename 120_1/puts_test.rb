class Monster
  attr_accessor :name, :age, :gender

  def initialize(n, a, g)
    @name = n
    @age = a
    @gender = g
  end

  # def to_s
  #   puts "#{name} : #{age} : #{gender}"
  # end
end

monster = Monster.new('Frank', '200', 'male')
puts monster
# => nil
# Frank : 200 : male
# <Monster:0x00007fa947005f08>