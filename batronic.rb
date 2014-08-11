#  _          _                _    
# | |__  __ _| |_ _ _ ___ _ _ (_)__ 
# | '_ \/ _` |  _| '_/ _ \ ' \| / _|
# |_.__/\__,_|\__|_| \___/_||_|_\__|
# stephan.com 2014

require './config/environment.rb'
require './models/batter'
require 'ruby-progressbar'
require 'terminal-table'

# Batter.all.each do |b|
#   puts "#{b.player_key} #{b.batting_statistics.count}" if b.batting_statistics.count>1
# end

def most_improved(year1, year2, min_bats = 200)
  puts "Finding most improved batting average from #{year1} to #{year2} for players with at least #{min_bats} at-bats (ignoring ties)"

  bar = ProgressBar.create(total: Batter.count)
  winner = Batter.all.most_improved(year1, year2, min_bats) do
    bar.increment
  end
  bar.finish
  puts "Most Improved #{year1}-#{year2}: #{winner}"
end

def team_slugging(team, year)
  puts "Slugging percentage for all players on #{team} in #{year}"

  players = {}
  BattingStatistic.where(year: year, team: team).player_slugging do |batter, slugging_percentage|
    players[batter.full_name] = '%0.3f' % slugging_percentage.to_f
  end

  puts Terminal::Table.new(:rows => players.sort_by(&:last).reverse)
end

def triple_crown(league, year)
  puts "Looking for triple crown winner in league #{league} for #{year}"

  winner = BattingStatistic.triple_crown(league, year)
  if winner
    puts "Winner found!"
    puts winner.to_s
  else
    puts "(no winner)"
  end
end

puts
puts
most_improved(2009, 2010, 200)
puts
puts
team_slugging('OAK', 2007)
puts
puts
[2011, 2012].each do |year|
  %w(AL NL).each do |league|
    triple_crown(league, year)
    puts
  end
end
puts