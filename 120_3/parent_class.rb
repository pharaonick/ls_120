class ParentClass
  def greet(msg)
    puts msg
  end

  def hello
    'hi'
  end

  def self.hi
    # `self` here is `ParentClass`
    greeting = ParentClass.new  # greeting assigned a `ParentClass` instance
    greeting.greet(hello)       # `greet` called on that instance, and passed the 
                                # return value of the `hello` method call as an argument.
                                # HOWEVER, when we call a method with no explicit receiver, 
                                # the calling object is `self`. So in this case, we are passing the 
                                # return value of `self.hello` as an argument, 
                                # i.e. the result of calling `hello` on `ParentClass`. 
                                # There is no `hello` class method, hence the error.
                                # `greeting.greet(greeting.hello)` would work.
  end

  def hi
    # `self` here is an instance of `ParentClass`
    greeting2 = ParentClass.new
    greeting2.greet(hello) # here, because `self` is an instance of ParentClass, 
                           # imethod `hello` is available to the default caller
  end
end

ParentClass.hi # => undefined local variable or method `hello' for ParentClass:Class (NameError)

ParentClass.new.hi # 'hi'
# note that this instance of ParentClass is different to the one
# instantiated as aprt of the `ParentClass#hi` imethod call