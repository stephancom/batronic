require 'csv'
require 'logger'
require 'active_record'
require './models/batter'
require 'rake-progressbar'

PLAYERS_FILE = 'Master-small.csv'
STATS_FILE = 'Batting-07-12.csv'

namespace :seeds do
  desc 'load the players file'
  task :players do
    puts "Loading players"
    Player.destroy_all

    fields = []
    first = true
    bar = RakeProgressbar.new(CSV.read(PLAYERS_FILE).length) # this is a sort of wasteful way to count :(
    CSV.foreach(PLAYERS_FILE) do |row|
      bar.inc

      if first
        fields = row
        first = false
      end

      Batter.create(
        player_key: row[fields.find_index('playerID')],
        birth_year: row[fields.find_index('birthYear')],
        first_name: row[fields.find_index('nameFirst')],
        last_name:  row[fields.find_index('nameLast')]
      )
    end
    bar.finished
  end

  desc 'load the statistics file'
  task :batting_statistics do
    puts "Loading statistics"
    BattingStatistic.destroy_all

    fields = []
    first = true
    bar = RakeProgressbar.new(CSV.read(STATS_FILE).length) # this is a sort of wasteful way to count :(
    CSV.foreach(STATS_FILE) do |row|
      bar.inc

      if first
        fields = row
        first = false
      end

      BattingStatistic.create(
        player_key:   row[fields.find_index('playerID')],
        year:         row[fields.find_index('yearID')],
        league:       row[fields.find_index('league')],
        team:         row[fields.find_index('teamID')],
        at_bats:      row[fields.find_index('AB')],
        hits:         row[fields.find_index('H')],
        doubles:      row[fields.find_index('2B')],
        triples:      row[fields.find_index('3B')],
        homers:       row[fields.find_index('HR')],
        rbi:          row[fields.find_index('RBI')]
      )
    end
    bar.finished
  end

  desc 'load all seeds'
  task all: [:players, :batting_statistics] do
    puts "All seeds loaded"
  end
end
