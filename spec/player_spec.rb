require './player'

describe Player do
  subject(:player) { Player.new('leelatu01', 2975, 'Turanga', 'Leela') }

  # TODO TEST VALIDATIONS
  it { is_expected.to     respond_to(:id)           }
  it { is_expected.to     respond_to(:birth_year)   }
  it { is_expected.to     respond_to(:first_name)   }
  it { is_expected.to     respond_to(:last_name)    }
  it { is_expected.not_to respond_to(:id=)          }
  it { is_expected.not_to respond_to(:birth_year=)  }
  it { is_expected.not_to respond_to(:first_name=)  }
  it { is_expected.not_to respond_to(:last_name=)   }

  it "should deliver full name" do
    expect(player.full_name).to eq('Turanga Leela')
  end
end