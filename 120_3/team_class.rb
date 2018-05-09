class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def >(other_person)
    age > other_person.age
  end
end

class Team
  attr_accessor :name, :members

  def initialize(name)
    @name = name
    @members = []
  end

  def <<(person)
    members.push person
  end

  def +(other_team)
    temp_team = Team.new("Temporary Team")
    temp_team.members = members + other_team.members
    temp_team
  end

  def [](idx)
    members[idx]
  end
  # alt implementation of the above to show you don't have to use the same 
  # syntax (though it's usually better/clearer if you do...)
  def what_is_at(idx)
    members[idx]
  end

  def []=(idx, obj)
    members[idx] = obj
  end
  # ditto alt implementation of the setter
  def set_thing_at(thing, idx)
    members[idx] = thing
  end
end

cowboys = Team.new("Dallas Cowboys")
cowboys << Person.new("Troy Aikman", 48)
cowboys << Person.new("Emmitt Smith", 46)

niners = Team.new("San Francisco 49ers")
niners << Person.new("Joe Montana", 59)
niners << Person.new("Jerry Rice", 52)

dream_team = cowboys + niners
dream_team.name = "Dream Team"
puts dream_team.inspect
# #<Team:0x00007f853e07b5a0 @name="Dream Team", @members=[#<Person:0x00007f853e07bdc0 @name="Troy Aikman", @age=48>, #<Person:0x00007f853e07b7a8 @name="Emmitt Smith", @age=46>, #<Person:0x00007f853e07b668 @name="Joe Montana", @age=59>, #<Person:0x00007f853e07b618 @name="Jerry Rice", @age=52>]>

puts dream_team[2].inspect
puts dream_team.what_is_at(2).inspect
dream_team[4] = Person.new('Bobby Bob Bob', 102)
dream_team.set_thing_at(Person.new('NEWMAN', 45), 5)
puts dream_team.inspect


