class ChampionMastery < ActiveRecord::Base
  belongs_to :summoner
  belongs_to :champion

  def self.order_by_champion_points
    order('champion_points DESC')
  end
end
