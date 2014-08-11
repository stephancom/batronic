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
  # TODO how to handle ties in one category or another?

  crown_methods = [:batting_average, :homers, :rbi]
  top_values = {}
  top_keys = {}
  # initialize hashes
  crown_methods.each do |method|
    top_values[method] = 0
    top_keys[method] = []
  end
  # iterate through stats keeping track of winner in each category
  BattingStatistic.where(year: year, league: league).each do |s|
    next if s.at_bats < 400
    crown_methods.each do |method|
      value = s.send(method)
      if value > top_values[method]
        top_values[method] = value
        top_keys[method] = [s.player_key]
      elsif value == top_values[method]
        top_keys[method] << s.player_key
      end
    end
  end

  if top_keys[:batting_average] == top_keys[:homers] and top_keys[:homers] == top_keys[:rbi]
    puts "Winner found!"
    puts Batter.find_by(player_key: top_keys[:rbi]).to_s
  else
    puts "(no winner)"
  end
end

# puts
# puts
# most_improved(2009, 2010, 200)
# puts
puts
team_slugging('OAK', 2007)
puts
# puts
# [2011, 2012].each do |year|
#   %w(AL NL).each do |league|
#     triple_crown(league, year)
#     puts
#   end
# end
# puts