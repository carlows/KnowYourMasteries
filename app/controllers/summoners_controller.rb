class SummonersController < ApplicationController
  layout 'application_user', only: [:index, :show]

  def search
  end

  def index
  end

  def show
    alphabet = 'SABCDEFGHIJKLMOPQRTUVWXYZNn'

    custom_sort = ->(a, b) do
      a.split('').each_with_index do |char, i|
        return alphabet.index(a[i]) <=> alphabet.index(b[i]) if a[i] != b[i]
      end

      return alphabet.index(' ') <=> alphabet.index(b[-1])
    end

    @summoner = Summoner.includes(:champion_masteries => :champion).find(params[:id])
    @summoner_masteries = @summoner.champion_masteries.includes(:champion).order_by_champion_points.as_json(include: :champion)
    @summoner_mastery_grades = @summoner.champion_masteries.group_by{ |mastery| mastery.highest_grade[0] }.map { |key, value| [ key, value.count ] if key != 'n' }.compact.sort(&custom_sort).to_h

    summoner_mastery_ids = @summoner.champion_masteries.pluck(:id)
    summoner_stat_ids = @summoner.champion_stats.pluck(:id)

    @ranked_champions = Champion.includes(:champion_masteries, :champion_stats).where(champion_masteries: {id: summoner_mastery_ids}, champion_stats: {id: summoner_stat_ids}).as_json(include: [:champion_masteries, :champion_stats])
  end

  def create
    summoner = Summoner.where('lower(name) = ? AND region = ?', params[:summoner].downcase, params[:region]).first
    if summoner
      sum = Summoner.update_summoner(summoner)
      redirect_to summoner_path(sum.id)
    else
      begin
        sum = Summoner.create_summoner(params[:summoner], params[:region])
        redirect_to summoner_path(sum.id)
      rescue RiotApi::SummonerNotFoundException
        redirect_to summoner_not_found_path
      rescue RiotApi::RateLimitExceededException
        redirect_to apierror_path
      rescue RiotApi::RiotServerErrorException
        redirect_to apierror_path
      end
    end
  end

  def update
  end

  def not_found
    render layout: 'error'
  end

  def apierror
    render layout: 'error'
  end
end
