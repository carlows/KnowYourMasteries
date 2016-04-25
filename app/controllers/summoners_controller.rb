class SummonersController < ApplicationController
  def search
  end

  def index
  end

  def show
  end

  def create
    sum = Summoner.create_summoner(params[:summoner], params[:region])

    redirect_to summoner_path(sum.id)
  end

  def update
  end
end
