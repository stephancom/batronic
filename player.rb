class Player
  attr_reader :id
  attr_reader :birth_year
  attr_reader :first_name
  attr_reader :last_name

  def initialize(id, birth_year, first_name, last_name)
            @id = id
    @birth_year = birth_year
    @first_name = first_name
     @last_name = last_name
     #  TODO VALIDATIONS
  end
  
  def full_name
    [@first_name, @last_name].join(' ')
  end
end