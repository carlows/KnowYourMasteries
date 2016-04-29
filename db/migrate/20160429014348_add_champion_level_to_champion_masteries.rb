class AddChampionLevelToChampionMasteries < ActiveRecord::Migration
  def change
    add_column :champion_masteries, :champion_level, :integer
  end
end
