module MakeSound
  def roar
    puts "ROOOOOOARRR!!"
  end

  def speak(words)
    puts words
  end
end

module Flyable
  def fly
    puts "I'm flying!!"
  end
end

class Monster
  include MakeSound

  @@monster_count = 0

  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def self.count
    puts "#{@@monster_count} monsters have been created..."
  end
end

class Creeper < Monster
  attr_accessor :stealth, :teeth

  def initialize(name, stealth, teeth)
    super(name)
    @stealth = stealth
    @teeth = teeth
    @@monster_count += 1
  end

  def to_s
    "My name is #{name} and I have a stealth rating of #{stealth} and #{teeth} teeth."
  end
end

class Flyer < Monster
  include Flyable

  def initialize(second_name)
    super # no second argument passed to imethod so it passes `second_name` to `super` too
    @second_name = second_name
    @@monster_count += 1
  end

  # manual getter method
  def second_name
    @second_name
  end

  def public_fave_num
    puts "my fave num is #{fave_num}" # cannot access with `self` because private
  end

  private
  def fave_num
    rand(14)
  end
end

creeping_monster1 = Creeper.new('creepster', 90, 13)
puts creeping_monster1
creeping_monster2 = Creeper.new('crawler', 50, 23)
puts creeping_monster2
Monster.count
creeping_monster2.name = 'crawling bob'
puts creeping_monster2
Monster.count

creeping_monster2.roar
creeping_monster1.speak('Well hello there I am a monster')
# creeping_monster1.fly # gives error as expected

flyer1 = Flyer.new('barry')
puts flyer1
puts flyer1.name
puts flyer1.second_name
flyer1.fly
Monster.count

flyer1.roar
flyer1.speak("I already roared what more do you want")

p Flyer.ancestors # => [Flyer, Flyable, Monster, MakeSound, Object, Kernel, BasicObject]

# puts flyer1.fave_num # gives error as expected because private imethods not
# available outside of class
flyer1.public_fave_num