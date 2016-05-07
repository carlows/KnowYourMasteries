class Renamecolumnd < ActiveRecord::Migration
  def change
    rename_column :summoners, :main_champion_id, :champion_id
  end
end
