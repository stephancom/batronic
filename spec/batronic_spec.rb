require 'spec_helper'
require './batronic'

describe Batronic do
  subject(:roster) { Batronic.new('foo', 'bar') }

  it "should be able to find a player by ID" do
      expect(roster).to respond_to(:find_player_by_id)
  end
end