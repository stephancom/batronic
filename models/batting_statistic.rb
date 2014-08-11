require_relative '../config/environment.rb'

class BattingStatistic < ActiveRecord::Base
  validates :player_key, uniqueness: { scope: [:year, :team]}
  validates :league, inclusion: {in: %w(AL NL)}
  validates :at_bats, :hits, :doubles, :triples, :homers, :rbi, numericality: {only_integer: true, greater_than_or_equal_to: 0}

  before_validation :assure_no_nils

  belongs_to :batter, foreign_key: :player_key, primary_key: :player_key, inverse_of: :batting_statistics

  def batting_average
    at_bats == 0 ? 0 : (hits.to_f/at_bats).round(3)
  end

  def slugging_percentage
    at_bats == 0 ? 0 : (((hits-doubles-triples-homers) + (2 * doubles) + (3 * triples) + (4 * homers)).to_f/at_bats).round(3)
  end

  def self.player_slugging
    all.each do |s|
      yield Batter.find_by(player_key: s.player_key), s.slugging_percentage
    end
  end

  CROWN_METHODS = [:batting_average, :homers, :rbi]

  def self.triple_crown(league, year)
    top_values = {}
    top_keys = {}
    # initialize hashes
    CROWN_METHODS.each do |method|
      top_values[method] = 0
      top_keys[method] = []
    end
    # iterate through stats keeping track of winner in each category
    where(year: year, league: league).each do |s|
      next if s.at_bats < 400
      CROWN_METHODS.each do |method|
        value = s.send(method)
        if value > top_values[method]
          top_values[method] = value
          top_keys[method] = [s.player_key]
        elsif value == top_values[method]
          top_keys[method] << s.player_key
        end
      end
    end

    winner = (top_keys[:batting_average] & top_keys[:homers] & top_keys[:rbi]).first
    Batter.find_by(player_key: winner)
  end

  # TODO aggregate averages/percentages

  private

  def assure_no_nils
    self.at_bats ||= 0
    self.hits    ||= 0
    self.doubles ||= 0
    self.triples ||= 0
    self.homers  ||= 0
    self.rbi     ||= 0
  end
end