require_relative '../config/environment.rb'

class Player < ActiveRecord::Base
  validates :player_key, presence: true, uniqueness: true

  def full_name
    [first_name, last_name].join(' ')
  end

  def to_s
    "#{full_name} - b. #{birth_year}"
  end

  before_validation :check_player_key

  private

  def check_player_key
    i = 1
    while player_key.nil? or Player.exists?(player_key: player_key)
      self.player_key = ((last_name || '')[0..4] + (first_name || '')[0..1]).downcase + ('%02d' % i)
      i = i + 1
    end
  end
end