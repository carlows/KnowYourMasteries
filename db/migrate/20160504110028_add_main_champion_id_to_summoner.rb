class AddMainChampionIdToSummoner < ActiveRecord::Migration
  def change
    add_column :summoners, :main_champion_id, :integer
  end
end
