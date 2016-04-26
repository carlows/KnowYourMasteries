class AddIndexsToSummoner < ActiveRecord::Migration
  def change
    add_index :summoners, :name
  end
end
