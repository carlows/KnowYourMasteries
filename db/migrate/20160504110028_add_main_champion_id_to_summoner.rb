class AddMainChampionIdToSummoner < ActiveRecord::Migration
  def change
    add_column :summoners, :champion_id, :integer
  end
end
