require 'riot_api_requests'

class Summoner < ActiveRecord::Base
  has_many :champion_masteries

  validates :name, presence: true
  validates :summoner_id, presence: true
  validates :region, presence: true
  validates :logo_id, presence: true

  def self.update_summoner(summoner)
    api = RiotApiRequests.new

    summoner_data = api.request_summoner_data(name, summoner.region).first.last
    summoner.logo_id = summoner_data["profileIconId"]
    summoner.champion_masteries.delete_all

    summoner.save(:validate => false)

    mastery_data = api.request_mastery_data(summoner.summoner_id, summoner.region)

    inserts = []
    mastery_data.each do |mastery|
      if mastery.has_key?("highestGrade")
        grade = mastery["highestGrade"]
      else
        grade = "n"
      end 

      chest_granted = mastery["chestGranted"] ? 't' : 'f'
      champion_points = mastery["championPoints"]
      chest_granted = mastery["chestGranted"]
      champion_id = mastery["championId"]

      inserts.push "(#{champion_points}, 'f', '#{grade}', #{champion_id}, #{summoner.id}, '#{Time.current.to_s}', '#{Time.current.to_s}')"
    end

    sql = "INSERT INTO champion_masteries (champion_points, chest_granted, highest_grade, champion_id, summoner_id, created_at, updated_at) VALUES #{inserts.join(", ")};"

    ChampionMastery.connection.execute sql

    summoner
  end

  def self.create_summoner(name, region)
    api = RiotApiRequests.new

    summoner_data = api.request_summoner_data(name, region).first.last

    summoner = Summoner.new(name: summoner_data["name"],
                            region: region,
                            summoner_id: summoner_data["id"],
                            logo_id: summoner_data["profileIconId"])

    mastery_data = api.request_mastery_data(summoner.summoner_id, region)
    
    summoner.save(:validate => false)

    inserts = []
    mastery_data.each do |mastery|
      if mastery.has_key?("highestGrade")
        grade = mastery["highestGrade"]
      else
        grade = "n"
      end 

      chest_granted = mastery["chestGranted"] ? 't' : 'f'
      champion_points = mastery["championPoints"]
      chest_granted = mastery["chestGranted"]
      champion_id = mastery["championId"]

      inserts.push "(#{champion_points}, 'f', '#{grade}', #{champion_id}, #{summoner.id}, '#{Time.current.to_s}', '#{Time.current.to_s}')"
    end

    sql = "INSERT INTO champion_masteries (champion_points, chest_granted, highest_grade, champion_id, summoner_id, created_at, updated_at) VALUES #{inserts.join(", ")};"

    ChampionMastery.connection.execute sql
    summoner
  end
end
