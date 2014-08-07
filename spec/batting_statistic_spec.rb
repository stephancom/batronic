require 'spec_helper'
require './models/batting_statistic'
require 'shared_examples_for_players'

describe BattingStatistic do
  subject(:stats) { create(:batting_statistic) }

  # TODO TEST VALIDATIONS
  it { is_expected.to respond_to(:at_bats) }
  it { is_expected.to respond_to(:hits)    }
  it { is_expected.to respond_to(:doubles) }
  it { is_expected.to respond_to(:triples) }
  it { is_expected.to respond_to(:homers)  }
  it { is_expected.to respond_to(:rbi)     }

  it { is_expected.to respond_to(:batter)  }

  it "has a Batter object" do
    expect(stats.batter).to be_a(Batter)
  end

  describe "the batter" do
    let(:full_name) { 'Bill Buckner' }
    subject(:batter) { stats.batter }

    it_behaves_like 'a player'
  end

  describe "batting average" do
    it "should compute 0.5 for 50 hits and 100 at-bats" do
      stats = create(:batting_statistic, at_bats: 100, hits: 50)
      expect(stats.batting_average).to eq(0.5)
    end
    it "should compute 0.333 for 20 hits and 60 at-bats" do
      # as opposed to 0.3333333333
      stats = create(:batting_statistic, at_bats: 60, hits: 20)
      expect(stats.batting_average).to eq(0.333)
    end
    it "should compute 0.2 for 10 hits and 50 at-bats" do
      stats = create(:batting_statistic, at_bats: 50, hits: 10)
      expect(stats.batting_average).to eq(0.2)
    end
    it "should compute 0 for 0 hits and 0 at-bats" do
      stats = create(:batting_statistic, at_bats: 0, hits: 0)
      expect(stats.batting_average).to eq(0)
    end
  end

  describe "slugging percentage" do
    it "should compute 0.694 for 540 at bats, 170 hits, 46 doubles, 3 triples and 51 home runs" do
      stats = create(:batting_statistic, at_bats: 540, hits: 170, doubles: 46, triples: 3, homers: 51)
      expect(stats.slugging_percentage).to eq(0.694)
    end

    it "should compute 0.888 for 80 at bats, 40 hits, 12 doubles, 5 triples and 3 home runs" do
      stats = create(:batting_statistic, at_bats: 80, hits: 40, doubles: 12, triples: 5, homers: 3)
      expect(stats.slugging_percentage).to eq(0.888)
    end

    it "should compute 0.987 for 76 at bats, 46 hits, 14 doubles, 6 triples and 1 home runs" do
      stats = create(:batting_statistic, at_bats: 76, hits: 46, doubles: 14, triples: 6, homers: 1)
      expect(stats.slugging_percentage).to eq(0.987)
    end

    it "should compute 0 for 0 hits" do
      stats = create(:batting_statistic, at_bats: 0)
      expect(stats.slugging_percentage).to eq(0)
    end
  end
end