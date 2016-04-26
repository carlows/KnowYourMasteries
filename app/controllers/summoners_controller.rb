class SummonersController < ApplicationController
  def search
  end

  def index
  end

  def show
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
