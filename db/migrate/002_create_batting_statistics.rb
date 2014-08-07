class CreateBattingStatistics < ActiveRecord::Migration
  def change
    create_table(:batting_statistics) do |t|
      t.string :player_key, null: false, default: ''
      t.integer :year
      t.string :league, length: 2
      t.string :team, length: 3
      # input file includes R, SB, CS - ??
      t.integer :at_bats
      t.integer :hits
      t.integer :doubles
      t.integer :triples
      t.integer :homers
      t.integer :rbi
    end
  end
end