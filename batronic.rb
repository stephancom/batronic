require './config/environment.rb'
require './models/batter'
require 'ruby-progressbar'

# Batter.all.each do |b|
#   puts "#{b.player_key} #{b.batting_statistics.count}" if b.batting_statistics.count>1
# end

def most_improved
  puts "Finding most improved batting average from 2009 to 2010 for players with at least 200 at-bats (ignoring ties)"

  # we presume this to mean at-bats in 2009-2010, not lifetime
  # there is probably a more efficient way to do this directly in the database
  candidates = {}
  bar = ProgressBar.create(total: Batter.count)
  Batter.all.each do |b|
    bar.increment
    twothousand09_stats = b.batting_statistics.find_by(year: 2009)
    twothousand10_stats = b.batting_statistics.find_by(year: 2010)

    # skip players with no records for either year or insufficient at bats
    next if twothousand10_stats.nil? or twothousand09_stats.nil?
    next if twothousand09_stats.at_bats + twothousand10_stats.at_bats < 200

    improvement = twothousand10_stats.batting_average - twothousand09_stats.batting_average

    # though the spec did not explicitly say so, we assume that we can skip players who got worse
    next if improvement < 0

    candidates[b.player_key] = improvement
  end
  bar.finish

  winner_key = candidates.sort_by( &:last).last
  winner = Batter.find_by(player_key: winner_key)

  puts "Most Improved 2009-2010: #{winner}"
end

most_improved()