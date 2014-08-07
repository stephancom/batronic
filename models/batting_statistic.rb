require_relative '../config/environment.rb'

class BattingStatistic < ActiveRecord::Base
  validates :player_key, uniqueness: { scope: [:year, :team]}
  validates :league, inclusion: {in: %w(AL NL)}

  belongs_to :batter, foreign_key: :player_key, primary_key: :player_key, inverse_of: :batting_statistics

  def batting_average
    at_bats == 0 ? 0 : (hits.to_f/at_bats).round(3)
  end

  def slugging_percentage
    at_bats == 0 ? 0 : (((hits-doubles-triples-homers) + (2 * doubles) + (3 * triples) + (4 * homers)).to_f/at_bats).round(3)
  end

  # TODO aggregate averages/percentages
end