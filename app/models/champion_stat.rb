class ChampionStat < ActiveRecord::Base
  belongs_to :summoner
  belongs_to :champion

  def winrate
    ((matches_won.to_f / matches_played.to_f) * 100).to_i
  end

  def kda
    (kills + assists) / deaths.to_f
  end

  def attributes
    super.merge({'winrate' => winrate, 'kda' => kda})
  end
end
