class AddNameToCourts < ActiveRecord::Migration[5.2]
  def change
    add_column :courts, :name, :string
  end
end
