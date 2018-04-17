class MyCar
  
  attr_accessor :color
  attr_reader :year
  # attr_writer


  # I THINK WE SHOULD BE USING THE GETTER/SETTER METHODS HERE TOO, RIGHT?
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @current_speed = 0

    # should this be instance var or arg???
    puts "You are driving a #{@color} #{year} #{model}. Sweet."
  end

  # # RATHER THAN DEFINING THESE SEPARATELY, SIMPLY `attr_accessor :color`
  # # getter method -- needed to access var in program since only methods can be called?
  # def color
  #   @color
  # end

  # # setter method
  # def color=(color)
  #   @color = color
  # end


  # WHAT ARE THE SCOPING RULES OF INSTANCE VARIABLES & METHODS?
  # @current_speed is available here despite not being passed in
  # presume scoped to class...?

  def current_speed
    puts "Your current_speed is #{@current_speed} mph."
  end

  def speed_up(increment)
    @current_speed += increment
    puts "You hit the gas and speed up by #{increment} mph!"
  end

  def brake(decrement)
    @current_speed -= decrement
    puts "You hit the brake and slow down by #{decrement} mph."
  end

  def shut_off
    @current_speed = 0
    puts "You, um, turn the car off?"
  end

  def spray_paint(new_color)
    # `self.color` here is a method call returning @color instance var
    # if we just write `color`, Ruby thinks we are initializing a new local var called `color` not calling the setter method
    # note we could just directly access the instance var and update it, i.e. `@color = new_color` but it's best practice to go via the setter method
    self.color = new_color
    puts "[new_color] You spray your car #{new_color}"
    puts "[color] You spray your car #{color}"
    puts "[@color] You spray your car #{@color}" # compare results if just call `color = new_color`... (and consider how the return value of the line above is the same but for a different reason (I think!))
  end 

end

boris = MyCar.new('2003', 'black', 'fast car')
# boris.current_speed
# boris.speed_up(50)
# boris.current_speed
# boris.speed_up(100)
# boris.current_speed
# boris.brake(80)
# boris.current_speed
# boris.shut_off
# boris.current_speed

# boris.color = 'yellow' # SYNTACTICAL SUGAR... boris.color=('yellow')
# p boris.color

# p boris.year
# YOU CAN ONLY DO THE BELOW IF YOU SPECIFY SETTER METHOD 
# boris.year = '450' 
# p boris.year

boris.spray_paint('purple')
p boris.color




