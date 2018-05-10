class Parent
  attr_accessor :name
end

class Child < Parent; end

parent = Parent.new
child = Child.new

parent.name # nil
child.name # nil
parent.name = 'bob'
child.name # error
child.name = 'little bob'
child.name # 'little bob'
parent.name = 'BIG bob'
parent.name # 'BIG bob'
child.name # 'little bob'