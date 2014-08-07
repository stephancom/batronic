require './models/player'
require './models/batting_statistic'

class Batter < Player
  has_many :batting_statistics, foreign_key: :player_key, primary_key: :player_key
end