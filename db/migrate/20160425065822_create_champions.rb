class CreateChampions < ActiveRecord::Migration
  def change
    create_table :champions do |t|
      t.integer :champion_id
      t.string :name
      t.string :key
      t.timestamps null: false
    end
  end
end
