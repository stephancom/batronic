require_relative '../config/environment.rb'

class BattingStatistic < ActiveRecord::Base
  belongs_to :batter, foreign_key: :player_key, primary_key: :player_key, inverse_of: :batting_statistics

  def batting_average
    at_bats == 0 ? 0 : hits.to_f/at_bats
  end
end