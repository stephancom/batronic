require './models/player'
require './models/batting_statistic'

class Batter < Player
  has_many :batting_statistics, foreign_key: :player_key, primary_key: :player_key

  def year_to_year_batting_improvement(year1, year2, min_bats)
    stats1 = batting_statistics.find_by(year: year1)
    stats2 = batting_statistics.find_by(year: year2)

    return 0 if stats1.nil? or stats2.nil? or stats1.at_bats + stats2.at_bats < min_bats

    stats2.batting_average-stats1.batting_average
  end

  # there is probably a more efficient way to do this directly in the database to statistics records
  def self.most_improved(year1, year2, min_bats)
    candidates = {}
    all.each do |b|
      yield if block_given?
      improvement = b.year_to_year_batting_improvement(year1, year2, min_bats)
      candidates[b.player_key] = improvement
    end
    winner_key = candidates.sort_by( &:last).last
    find_by(player_key: winner_key)
  end
end