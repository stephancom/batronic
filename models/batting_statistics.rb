require_relative '../config/environment.rb'

class BattingStatistics < ActiveRecord::Base
  def batting_average
    hits.to_f/at_bats
  end
end