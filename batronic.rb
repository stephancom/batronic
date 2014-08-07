require './config/environment.rb'
require './models/batter'
require 'ruby-progressbar'
require 'terminal-table'

# Batter.all.each do |b|
#   puts "#{b.player_key} #{b.batting_statistics.count}" if b.batting_statistics.count>1
# end

def most_improved(year1, year2, min_bats = 200)
  puts "Finding most improved batting average from #{year1} to #{year2} for players with at least #{min_bats} at-bats (ignoring ties)"

  # we presume this to mean at-bats in 2009-2010, not lifetime
  # there is probably a more efficient way to do this directly in the database
  candidates = {}
  bar = ProgressBar.create(total: Batter.count)
  Batter.all.each do |b|
    bar.increment
    twothousand09_stats = b.batting_statistics.find_by(year: year1)
    twothousand10_stats = b.batting_statistics.find_by(year: year2)

    # skip players with no records for either year or insufficient at bats
    next if twothousand10_stats.nil? or twothousand09_stats.nil?
    next if twothousand09_stats.at_bats + twothousand10_stats.at_bats < min_bats

    improvement = twothousand10_stats.batting_average - twothousand09_stats.batting_average

    # though the spec did not explicitly say so, we assume that we can skip players who got worse
    next if improvement < 0

    candidates[b.player_key] = improvement
  end
  bar.finish

  winner_key = candidates.sort_by( &:last).last
  winner = Batter.find_by(player_key: winner_key)

  puts "Most Improved #{year1}-#{year2}: #{winner}"
end

def team_slugging(team, year)
  puts "Slugging percentage for all players on #{team} in #{year}"

  players = {}
  BattingStatistic.where(year: year, team: team).each do |s|
    players[Batter.find_by(player_key: s.player_key).full_name] = '%0.3f' % s.slugging_percentage.to_f
  end

  puts Terminal::Table.new(:rows => players.sort_by(&:last).reverse)
end

most_improved(2009, 2010, 200)
puts
puts
team_slugging('OAK', 2007)