require 'riot_api_requests'

class Summoner < ActiveRecord::Base
  has_many :champion_masteries
  has_many :champion_stats

  validates :name, presence: true
  validates :summoner_id, presence: true
  validates :region, presence: true
  validates :logo_id, presence: true

  def mastery_score
    champion_masteries.sum(:champion_level)
  end

  def self.update_summoner(summoner)
    api = RiotApiRequests.new

    summoner_data = api.request_summoner_data(name, summoner.region).first.last
    champion_stats_data = api.request_champion_ranked_stats_data(summoner.summoner_id, summoner.region)

    summoner.logo_id = summoner_data["profileIconId"]
    summoner.champion_masteries.delete_all
    summoner.champion_stats.delete_all

    summoner.save(:validate => false)

    mastery_data = api.request_mastery_data(summoner.summoner_id, summoner.region)

    masteries = []
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
      champion_level = matery["championLevel"]

      masteries.push "(#{champion_points}, #{chest_granted}, #{champion_level}, '#{grade}', #{champion_id}, #{summoner.id}, '#{Time.current.to_s}', '#{Time.current.to_s}')"
    end

    champions = []
    unless champion_stats_data.nil? 
      champion_stats_data["champions"].each do |stat|
        champion_id = stat["id"]
        matches_played = stat["stats"]["totalSessionsPlayed"]
        matches_won = stat["stats"]["totalSessionsWon"]
        matches_lost = stat["stats"]["totalSessionsLost"]
        kills = stat["stats"]["totalChampionKills"]
        assists = stat["stats"]["totalAssists"]
        deaths = stat["stats"]["totalDeathsPerSession"]
        current_time = Time.current.to_s
        champions.push "(#{matches_played}, #{matches_won}, #{matches_lost}, #{kills}, #{assists}, #{deaths}, #{champion_id}, #{summoner.id}, '#{current_time}', '#{current_time}')"
      end
    end

    champion_masteries_query = "INSERT INTO champion_masteries (champion_points, chest_granted, champion_level, highest_grade, champion_id, summoner_id, created_at, updated_at) VALUES #{masteries.join(", ")};"
    champion_stats_query = "INSERT INTO champion_stats (matches_played, matches_won, matches_lost, kills, assists, deaths, champion_id, summoner_id, created_at, updated_at) VALUES #{champions.join(", ")};"

    ActiveRecord::Base.transaction do
      ChampionMastery.connection.execute champion_masteries_query
      ChampionStat.connection.execute champion_stats_query unless champion_stats_data.nil?
    end

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
    champion_stats_data = api.request_champion_ranked_stats_data(summoner.summoner_id, region)
    summoner.save(:validate => false)

    masteries = []
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
      champion_level = mastery["championLevel"]

      masteries.push "(#{champion_points}, #{chest_granted}, #{champion_level}, '#{grade}', #{champion_id}, #{summoner.id}, '#{Time.current.to_s}', '#{Time.current.to_s}')"
    end

    champions = []
    unless champion_stats_data.nil? 
      champion_stats_data["champions"].each do |stat|
        champion_id = stat["id"]
        matches_played = stat["stats"]["totalSessionsPlayed"]
        matches_won = stat["stats"]["totalSessionsWon"]
        matches_lost = stat["stats"]["totalSessionsLost"]
        kills = stat["stats"]["totalChampionKills"]
        assists = stat["stats"]["totalAssists"]
        deaths = stat["stats"]["totalDeathsPerSession"]
        current_time = Time.current.to_s
        champions.push "(#{matches_played}, #{matches_won}, #{matches_lost}, #{kills}, #{assists}, #{deaths}, #{champion_id}, #{summoner.id}, '#{current_time}', '#{current_time}')"
      end
    end

    champion_masteries_query = "INSERT INTO champion_masteries (champion_points, chest_granted, champion_level, highest_grade, champion_id, summoner_id, created_at, updated_at) VALUES #{masteries.join(", ")};"
    champion_stats_query = "INSERT INTO champion_stats (matches_played, matches_won, matches_lost, kills, assists, deaths, champion_id, summoner_id, created_at, updated_at) VALUES #{champions.join(", ")};"

    ActiveRecord::Base.transaction do
      ChampionMastery.connection.execute champion_masteries_query
      ChampionStat.connection.execute champion_stats_query unless champion_stats_data.nil?
    end

    summoner
  end
end
