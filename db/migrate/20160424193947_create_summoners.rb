class CreateSummoners < ActiveRecord::Migration
  def change
    create_table :summoners do |t|
      t.string :name
      t.integer :summoner_id
      t.integer :logo_id

      t.timestamps null: false
    end
  end
end
