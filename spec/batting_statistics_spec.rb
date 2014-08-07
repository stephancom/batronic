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

end