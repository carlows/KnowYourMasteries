require 'riot_api_requests'

class Summoner < ActiveRecord::Base
  has_many :champion_masteries

  validates :name, presence: true
  validates :summoner_id, presence: true
  validates :region, presence: true
  validates :logo_id, presence: true

  def self.create_summoner(name, region)
    api = RiotApiRequests.new
    champions = Champion.all

    summoner_data = api.request_summoner_data(name, region).first.last
    
    summoner = Summoner.new(name: summoner_data["name"], 
                            region: region, 
                            summoner_id: summoner_data["id"],
                            logo_id: summoner_data["profileIconId"])

    mastery_data = api.request_mastery_data(summoner.summoner_id, region)
    summoner.champion_masteries = []

    mastery_data.each do |mastery|
      champion_mastery = ChampionMastery.new(champion_points: mastery["championPoints"], chest_granted: mastery["chestGranted"])

      champion_mastery.highest_grade = mastery["highestGrade"] if mastery.has_key?("highestGrade")
      champion_mastery.champion = champions.find_by(champion_id: mastery["championId"])

      summoner.champion_masteries << champion_mastery
    end

    summoner.save
  end
end
