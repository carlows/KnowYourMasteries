class StatsController < ApplicationController
  layout 'application_user', only: [:show]

  def show
    @champion_mains = Champion.joins(:summoners).group('key').count
    @chests_unlocked = ChampionMastery.where(chest_granted: true).count
  end
end
