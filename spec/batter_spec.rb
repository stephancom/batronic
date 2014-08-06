require './batter'

describe Batter do
  subject(:player) { Batter.new('leelatu01', 2975, 'Turanga', 'Leela') }

  # TODO TEST VALIDATIONS
  it { is_expected.to respond_to(:at_bats)    }
  it { is_expected.to respond_to(:hits)       }
  it { is_expected.to respond_to(:doubles)    }
  it { is_expected.to respond_to(:triples)    }
  it { is_expected.to respond_to(:home_runs)  }
  it { is_expected.to respond_to(:rbi)        }

  it { is_expected.to respond_to(:at_bats=)   }
  it { is_expected.to respond_to(:hits=)      }
  it { is_expected.to respond_to(:doubles=)   }
  it { is_expected.to respond_to(:triples=)   }
  it { is_expected.to respond_to(:home_runs=) }
  it { is_expected.to respond_to(:rbi=)       }

  it "should deliver full name" do
    expect(player.full_name).to eq('Turanga Leela')
  end
end