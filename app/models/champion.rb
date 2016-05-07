class Champion < ActiveRecord::Base
  has_many :champion_masteries
  has_many :champion_stats
  has_many :summoners

  def mastery_points_average
    champion_masteries.average(:champion_points).to_i
  end

  def winrate_average
    champion_stats.average('((matches_won::float / matches_played::float) * 100)::integer').to_i
  end

  scope :by_summoner, -> (summoner_id) { where("champion_masteries.summoner_id = ? AND champion_stats.summoner_id = ?", summoner_id, summoner_id) }
end
