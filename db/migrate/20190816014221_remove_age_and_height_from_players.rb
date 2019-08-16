class RemoveAgeAndHeightFromPlayers < ActiveRecord::Migration[5.2]
  def change
    remove_column :players, :age
    remove_column :players, :height
  end
end
