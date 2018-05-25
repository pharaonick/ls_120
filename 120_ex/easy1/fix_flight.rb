class Flight
  attr_accessor :database_handle

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end

# OK as-is but might cause problems in future. How ameliorate?
- add accessor methods for @flight_number?
- remove them for @database_handle?!

- it's actually this latter
  - the database handle is likely just an implemenation detail
    which users of the class will have no need for, and so should
    not receive direct access to
  - making access to @database_handle easy means someone may use it in code
    - which means future mods to this class may break that code...
    - which means you may not even be allowed to mod this class if the dependent
      code is of greater concern!