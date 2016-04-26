class CreateChampionMasteries < ActiveRecord::Migration
  def change
    create_table :champion_masteries do |t|
      t.integer :summoner_id
      t.integer :champion_id

      t.integer :champion_points
      t.boolean :chest_granted
      t.string  :highest_grade
              
      t.timestamps null: false
    end
  end
end
