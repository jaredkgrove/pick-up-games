class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :name
      t.string :height
      t.integer :age
      t.text :bio
      
      t.timestamps
    end
  end
end
