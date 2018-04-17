=begin
EXPLANATION BELOW...

Private is for methods which are called within the same object, 
protected is for methods which can be called from any instance of the same class. 
That is the most basic definition of them. 
(https://launchschool.com/posts/bbfddf8f)

NB note that private methods cannot be called with explicit receiver, 
only an implicit one, **even if that that is still the same object repped
by self**
And
the exception to this is setter methods, which can be called with an explicit
receiver even if private

=end

class SecretThingPrivate

  def share_secret
    "The secret is #{secret}" # CANNOT be called with explicit `self` receiver
  end

  private

  def secret
    "shhh.. it's a secret!!"
  end
end

private_secret = SecretThingPrivate.new
#private_secret.secret # => error, private method called
private_secret.share_secret # => "The secret is shhh.. it's a secret!!"
another_private_secret = SecretThingPrivate.new
another_private_secret.share_secret # => "The secret is shhh.. it's a secret!!"

class SecretThingProtected

  def share_secret
    "The secret is #{self.secret}" # CAN be called without explicit `self` receiver
  end

  protected

  def secret
    "shhh.. it's a secret!!"
  end
end

protected_secret = SecretThingProtected.new
#protected_secret.secret # => error, protected method called
protected_secret.share_secret # => "The secret is shhh.. it's a secret!!"
another_protected_secret = SecretThingProtected.new
another_protected_secret.share_secret # => "The secret is shhh.. it's a secret!!"

###################################################################
# EXPLANATION!!!!!

# https://launchschool.com/posts/9f7db748

# don't want to expose interface to outside world
# multiple instances of class needed in same method call
# so must be protected vs private

class Person
  attr_writer :age

  def initialize(name)
    @name = name
  end

  def age_against(other)
    if age == other.age
      "#{name} is same age as #{other.name}."
    elsif age < other.age
      "#{name} is younger than #{other.name}."
    else
      "#{name} is older than #{other.name}."
    end
  end

protected

  def age
    @age
  end

  def name
    @name
  end
end


bob = Person.new("Bob")
bob.age = 20
jane = Person.new("Jane")
jane.age = 19
puts bob.age_against(jane)



# class method where class method needs to find instance/s based on imethod
# (note this example is probably not best practice because of the way the search is conducted but w/e for now)

class Person
  def self.find_secret_stuff(criteria)
    all_people = database_call_based_on(criteria) #=> [bob, jane, ...]
    all_people.select do |person|
      person.some_predicate_method?
    end
  end

protected

  def some_predicate_method?
    # logic that returns true or false
  end
end

# This wont work, because the method is protected
bob.some_predicate_method? 

















