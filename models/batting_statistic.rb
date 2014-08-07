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