class Pet
  attr_reader :species, :name

  def initialize(species, name)
    @species = species
    @name = name
  end
end

class Owner
  attr_accessor :number_of_pets
  attr_reader :name

  def initialize(name)
    @name = name
    @number_of_pets = 0
  end
end

class Shelter
  def initialize
    @adoption_list = {}
  end

  def adopt(owner, pet)
    if @adoption_list.key?(owner)
      @adoption_list[owner] << pet
    else
      @adoption_list[owner] = [pet]
    end
    owner.number_of_pets += 1
  end

  def print_adoptions
    @adoption_list.each do |owner, pets|
      puts "#{owner.name} has adopted the following pets:"
      pets.each do |pet|
        puts "a #{pet.species} named #{pet.name}"
      end
      puts ""
    end
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)

shelter.print_adoptions
# P Hanson has adopted the following pets:
# a cat named Butterscotch
# a cat named Pudding
# a bearded dragon named Darwin

# B Holmes has adopted the following pets:
# a dog named Molly
# a parakeet named Sweetie Pie
# a dog named Kennedy
# a fish named Chester

puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
# P Hanson has 3 adopted pets.

puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
# B Holmes has 4 adopted pets.