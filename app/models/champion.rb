class Champion < ActiveRecord::Base
  has_many :champion_masteries
  has_many :champion_stats
  has_many :summoners

  scope :by_summoner, -> (summoner_id) { where("champion_masteries.summoner_id = ? AND champion_stats.summoner_id = ?", summoner_id, summoner_id) }
end
