class CreateChampionStats < ActiveRecord::Migration
  def change
    create_table :champion_stats do |t|
      t.integer :champion_id
      t.integer :summoner_id

      t.integer :matches_played
      t.integer :matches_won
      t.integer :matches_lost
      t.integer :kills
      t.integer :assists
      t.integer :deaths

      t.index :champion_id
      t.index :summoner_id
      t.timestamps null: false
    end
  end
end
