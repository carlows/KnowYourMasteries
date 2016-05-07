class StatsController < ApplicationController
  layout 'application_user', only: [:show]

  def show
    @champion_mains = Champion.joins(:summoners).group('key').count
    @chests_unlocked = ChampionMastery.where(chest_granted: true).count
    @champions_data = Champion.includes(:champion_masteries, :champion_stats).all.as_json(methods: [:mastery_points_average, :winrate_average])
    @champion_comparison = Champion.all.map { |champ| [champ.mastery_points_average.to_i, champ.winrate_average.to_i, champ.name] }
  end
end
