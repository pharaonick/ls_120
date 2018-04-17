# Create an object in Ruby

class CoolPerson
  # stuff goes here
end

bob = CoolPerson.new


# Create a module and include it in the class

module MakeSound
  
  def speak(words)
    puts words
  end
  
end

class CoolPerson
  include MakeSound
end