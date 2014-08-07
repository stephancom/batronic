require_relative '../config/environment.rb'

class Player < ActiveRecord::Base
  def full_name
    [first_name, last_name].join(' ')
  end
end