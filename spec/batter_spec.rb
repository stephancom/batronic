require 'spec_helper'
require './models/batter'
require 'shared_examples_for_players'

describe Player do
  let(:full_name) { 'Turanga Leela' }
  subject(:batter) { create(:batter, birth_year: 2975, first_name: 'Turanga', last_name: 'Leela') }

  it "has a valid factory" do
    expect(FactoryGirl.build(:batter)).to be_valid
  end

  it { is_expected.to respond_to(:batting_statistics) }

  it_behaves_like 'a player'

  describe "with statistics" do
    before(:each) do
      @batter = create(:batter, first_name: 'Mighty', last_name: 'Casey')
      5.times do |i|
        create(:batting_statistic, player_key: @batter.player_key)
      end
    end

    it "should have five records" do
      expect(@batter.batting_statistics.count).to eq(5)
    end
  end

  describe "year to year improvement" do
    it "computes 1.5 for .2 -> 1.3" do
      @year1 = create(:batting_statistic, year: 1985, hits: 20, at_bats: 100)
      @batter = @year1.batter
      @year2 = create(:batting_statistic, batter: @batter, year: 1986, hits: 40, at_bats: 100)

      # hey, did you know this FAILS? it comes out to 0.9999999999
      # expect(0.3-0.2).to eq(0.1)

      expect(@batter.year_to_year_batting_improvement(1985, 1986)).to eq(0.2)
    end

    it "doesn't fail for a missing second year" do
      @year1 = create(:batting_statistic, year: 1975, hits: 20, at_bats: 100)
      @batter = @year1.batter

      expect{ @batter.year_to_year_batting_improvement(1975, 1976) }.not_to raise_error
    end

    it "doesn't fail for a missing first year" do
      @year1 = create(:batting_statistic, year: 1976, hits: 20, at_bats: 100)
      @batter = @year1.batter

      expect{ @batter.year_to_year_batting_improvement(1975, 1976) }.not_to raise_error
    end
  end

  describe "most improvement" do
    # the pain here is to I clear out the whole database, or do I stub find_by to 
    pending "needs tests"
  end
end