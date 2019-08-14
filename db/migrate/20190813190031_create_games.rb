class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :time
      t.string :skill_level
      t.integer :court_id

      t.timestamps
    end
  end
end
