require 'spec_helper'
require './models/player'
require 'shared_examples_for_players'

describe Player do
  let(:full_name) { 'Turanga Leela' }
  subject(:player) { create(:player, birth_year: 2975, first_name: 'Turanga', last_name: 'Leela') }

  it "has a valid factory" do
    expect(FactoryGirl.build(:player)).to be_valid
  end

  it_behaves_like 'a player'

  describe "automatic player keys" do
    it "should generate aaronha01 for Hank Aaron" do
      b = create(:batter, player_key: nil, birth_year: 1933, first_name: 'Hank', last_name: 'Aaron')
      expect(b.player_key).to eq('aaronha01')
    end
    it "should generate abercfr01 for Francis Abercrombie" do
      # interesting to note that the csv file has abercda01 ??
      b = create(:batter, player_key: nil, birth_year: 1851, first_name: 'Francis', last_name: 'Abercrombie')
      expect(b.player_key).to eq('abercfr01')
    end
    it "should generate coxte01 for Ted Cox" do
      b = create(:batter, player_key: nil, birth_year: 1955, first_name: 'Ted', last_name: 'Cox')
      expect(b.player_key).to eq('coxte01')
    end
    it "should generate unique codes for two names the same" do
      b1 = create(:batter, player_key: nil, first_name: 'George', last_name: 'Spelvin')
      expect(b1.player_key).to eq('spelvge01')
      b2 = create(:batter, player_key: nil, first_name: 'George', last_name: 'Spelvin')
      expect(b2.player_key).to eq('spelvge02')
    end
    it "should work with no first name" do
      b = create(:batter, player_key: nil, birth_year: 1955, first_name: 'Prince', last_name: nil)
      expect(b.player_key).to eq('pr01')
    end
    it "should work with no last name" do
      b = create(:batter, player_key: nil, birth_year: 1955, first_name: nil, last_name: 'Sting')
      expect(b.player_key).to eq('sting01')
    end
  end
end