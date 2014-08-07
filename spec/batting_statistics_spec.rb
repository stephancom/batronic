require 'spec_helper'
require './models/batting_statistics'

describe BattingStatistics do
  subject(:stats) { create(:batting_statistics) }

  # TODO TEST VALIDATIONS
  it { is_expected.to respond_to(:at_bats)    }
  it { is_expected.to respond_to(:hits)       }
  it { is_expected.to respond_to(:doubles)    }
  it { is_expected.to respond_to(:triples)    }
  it { is_expected.to respond_to(:homers)     }
  it { is_expected.to respond_to(:rbi)        }

  describe "batting average" do
    it "should compute 0.5 for 50 hits and 100 at-bats" do
      batter = create(:batting_statistics, at_bats: 100, hits: 50)
      expect(batter.batting_average).to eq(0.5)
    end
    it "should compute 0.2 for 10 hits and 50 at-bats" do
      batter = create(:batting_statistics, at_bats: 50, hits: 10)
      expect(batter.batting_average).to eq(0.2)
    end
  end
end