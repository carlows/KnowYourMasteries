class AddIndexsToChampionMastery < ActiveRecord::Migration
  def change
    add_index :champion_masteries, :champion_id
    add_index :champion_masteries, :summoner_id
  end
end
