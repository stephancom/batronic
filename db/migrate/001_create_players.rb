class CreatePlayers < ActiveRecord::Migration
  def change
      create_table(:players) do |t|
        t.string :type
        t.string :player_key, null: :false, default: ""
        t.integer :birth_year
        t.string :first_name
        t.string :last_name
      end

      add_index :players, :player_key, unique: true
    end  
end