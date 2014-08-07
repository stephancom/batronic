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
      batter = create(:batting_statistic, at_bats: 100, hits: 50)
      expect(batter.batting_average).to eq(0.5)
    end
    it "should compute 0.2 for 10 hits and 50 at-bats" do
      batter = create(:batting_statistic, at_bats: 50, hits: 10)
      expect(batter.batting_average).to eq(0.2)
    end
  end
end