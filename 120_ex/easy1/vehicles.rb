class Vehicle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def wheels(wheels = 4) # worth defining if plan on other children and are likely to have 4 wheels...
                         # also allows some wheel processing later if needed...
    wheels
  end

  def to_s
    "#{make} #{model}"
  end
end

class Car < Vehicle; end

class Motorcycle < Vehicle
  def wheels
    super(2)
  end
end

class Truck < Vehicle
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  def wheels
    super(6)
  end
end