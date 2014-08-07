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
end