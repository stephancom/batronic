class Batter < Player
  attr_accessor :at_bats
  attr_accessor :hits
  attr_accessor :doubles
  attr_accessor :triples
  attr_accessor :home_runs
  attr_accessor :rbi

  def initialize(id, birth_year, first_name, last_name)
            @id = id
    @birth_year = birth_year
    @first_name = first_name
     @last_name = last_name
     #  TODO VALIDATIONS
  end
end