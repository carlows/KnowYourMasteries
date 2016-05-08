class StatsController < ApplicationController
  layout 'application_user', only: [:show]

  def show
    @champion_mains = Champion.joins(:summoners).group('key').count
    @chests_unlocked = ChampionMastery.where(chest_granted: true).count
    @total_mastery_points = ChampionMastery.sum(:champion_points)
    @total_summoners = Summoner.all.count
    @total_excellent_grades = ChampionMastery.where("highest_grade = ? or highest_grade = ? or highest_grade = ?", 'S+', 'S', 'S-').count
    @total_full_masteries = ChampionMastery.where("champion_level = ?", 5).count
    @total_matches_played = ChampionStat.sum(:matches_played)
    @highest_mastery = ChampionMastery.order('champion_points DESC').first
    @champions_data = Champion.includes(:champion_masteries, :champion_stats).all.as_json(methods: [:mastery_points_average, :winrate_average])
    @champion_comparison_data = Champion.all.map { |champ| 
      { 
        'name' => champ.name,
        'data' => [{ 'x' => champ.mastery_points_average.to_i, 'y' => champ.winrate_average.to_i, 'marker' => { 'width' => 20, 'height' => 20, 'symbol' => "url(http://ddragon.leagueoflegends.com/cdn/6.9.1/img/champion/#{champ.key}.png)" } }]
      }
    }
  end
end
