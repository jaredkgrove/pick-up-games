class ChangeTimeFromStringToDatetimeInGames < ActiveRecord::Migration[5.2]
  def change
    change_column :games, :time, :datetime
  end
end
