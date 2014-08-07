require 'spec_helper'
require './models/batter'
require 'shared_examples_for_players'

describe Player do
  let(:full_name) { 'Turanga Leela' }
  subject(:batter) { create(:batter, birth_year: 2975, first_name: 'Turanga', last_name: 'Leela') }

  it "has a valid factory" do
    expect(FactoryGirl.build(:batter)).to be_valid
  end

  it_behaves_like 'a player'
end