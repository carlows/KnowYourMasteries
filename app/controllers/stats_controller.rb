class StatsController < ApplicationController
  layout 'application_user', only: [:show]

  def show
    @champion_mains = Champion.joins(:summoners).group('key').count
  end
end
