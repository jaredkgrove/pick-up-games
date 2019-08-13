class CreateSquadPlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :squad_players do |t|
      t.integer :player_id
      t.integer :squad_id

      t.timestamps
    end
  end
end
