require 'spec_helper'
require './models/player'

describe Player do
  subject(:player) { create(:player, birth_year: 2975, first_name: 'Turanga', last_name: 'Leela') }

  it "has a valid factory" do
    expect(FactoryGirl.build(:player)).to be_valid
  end

  # TODO TEST VALIDATIONS
  it { is_expected.to     respond_to(:id)           }
  it { is_expected.to     respond_to(:player_key)   }
  it { is_expected.to     respond_to(:birth_year)   }
  it { is_expected.to     respond_to(:first_name)   }
  it { is_expected.to     respond_to(:last_name)    }

  it "should deliver full name" do
    expect(player.full_name).to eq('Turanga Leela')
  end
end