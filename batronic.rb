require './player'

# the Batronic class represents a roster of Batters with their statistics
# CSV loading methods are included here for convenience
# it might be better to have this descend from a more abstract Roster class
class Batronic
  def initialize(players_file, batting_file)
    @players = Batronic.load_batters_file(players_file)
    Batronic.add_batting_statistice(@players, batting_file)
  end  

  # this sort of thing is why I would rather be using ActiveRecord
  def find_player_by_id(id)
    Player.new # TODO
  end

  class << self
    # returns an array of batters from the CSV
    def load_batters_file(players_file)
      []
    end

    # given an array of players and a file of batting statistics
    # add the statistics to the player
    def add_batting_statistice(players, batting_file)
      # TODO
    end
  end
end

# Batronic.new('Master-small.csv', 'Batting-07-12.csv')