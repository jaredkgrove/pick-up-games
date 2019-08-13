class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.integer :player_id
      t.integer :court_id

      t.timestamps
    end
  end
end
