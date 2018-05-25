class Pet
  attr_reader :animal, :name

  def initialize(animal, name)
    @animal = animal
    @name = name
  end
end

class Owner
  attr_reader :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def add_pet(pet)
    @pets << pet
  end

  def number_of_pets
    @pets.size
  end
end

class Shelter
  def initialize(available_pets)
    @available_pets = available_pets
    @adoption_records = {}
  end

  def adopt(person, pet)
    person.add_pet(pet)
    @available_pets.delete(pet)

    if @adoption_records.key?(person)
      @adoption_records[person] << pet
    else
      @adoption_records[person] = [pet]
    end
  end

  def print_adoptions
    @adoption_records.each do |person, pets|
      puts "#{person.name} has adopted the following pets:"

      pets.each do |pet|
        puts "a #{pet.animal} named #{pet.name}"
      end
      puts ""
    end
    puts "The Animal Shelter has the following unadopted pets:"
    @available_pets.each do |pet|
      puts "a #{pet.animal} named #{pet.name}"
    end
  end

  def unadopted_number
    @available_pets.size
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')
ashira       = Pet.new('cat', 'Ashira')
kaia         = Pet.new('cat', 'Kaia')
asta         = Pet.new('dog', 'Asta')
laddie       = Pet.new('dog', 'Laddie')
fluffy       = Pet.new('cat', 'Fluffy')
kat          = Pet.new('cat', 'Kat')
ben          = Pet.new('cat', 'Ben')
chatterbox   = Pet.new('parakeet', 'Chatterbox')
bluebell     = Pet.new('parakeet', 'Bluebell')

available_pets = [butterscotch, pudding, darwin, kennedy, sweetie, molly,
chester, ashira, kaia, asta, laddie, fluffy, kat, ben, chatterbox, bluebell]

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')
nick    = Owner.new('Nick')

shelter = Shelter.new(available_pets)
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.adopt(nick, ashira)
shelter.adopt(nick, kaia)
shelter.adopt(phanson, chatterbox)

shelter.print_adoptions

puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts "The Animal Shelter has #{shelter.unadopted_number} pets."

p phanson.pets
p bholmes.pets
p nick.pets