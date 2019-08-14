class AddAdminToSquadPlayers < ActiveRecord::Migration[5.2]
  def change
    add_column :squad_players, :admin, :boolean, default: false
  end
end
