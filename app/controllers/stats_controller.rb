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

    alphabet = 'SABCDEFGHIJKLMOPQRTUVWXYZNn'

    custom_sort = ->(a, b) do
      a.split('').each_with_index do |char, i|
        return alphabet.index(a[i]) <=> alphabet.index(b[i]) if a[i] != b[i]
      end

      return alphabet.index(' ') <=> alphabet.index(b[-1])
    end

    @mastery_grades = ChampionMastery.all.group_by{ |mastery| mastery.highest_grade[0] }.map { |key, value| [ key, value.count ] if key != 'n' }.compact.sort(&custom_sort).to_h
  end
end
