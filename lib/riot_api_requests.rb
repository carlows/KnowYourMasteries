require 'rest-client'
require 'json'
require 'riot_exceptions'

class RiotApiRequests

  def initialize
    @api_key = "?api_key=#{ENV['RIOT_API_KEY']}"

    @handle_response = Proc.new do | response, request, result |
      case response.code
      when 200
        JSON.parse(response)
      when 404
        raise RiotApi::SummonerNotFoundException
      when 429
        raise RiotApi::RateLimitExceededException
      else
        raise RiotApi::RiotServerErrorException
      end
    end
  end

  # url for summoner data:
  # https://lan.api.pvp.net/api/lol/lan/v1.4/summoner/by-name/summoner_name?api_key="
  def request_summoner_data(summoner_name, region)
    api_request_summonerid_url = get_region_url(region) + "summoner/by-name/"
    full_url = api_request_summonerid_url + summoner_name + @api_key

    RestClient.get(full_url, &@handle_response) 
  end

  def request_mastery_data(summoner_id, region)
    api_request_url = get_mastery_region_url(region) + "player/#{summoner_id}/champions" + @api_key

    RestClient.get(api_request_url, &@handle_response)
  end

  def request_champion_data
    api_request_url = "https://global.api.pvp.net/api/lol/static-data/lan/v1.2/champion" + @api_key

    RestClient.get(api_request_url, &@handle_response) 
  end

  private 

  def get_region_url(region)
    "https://#{region.downcase}.api.pvp.net/api/lol/#{region.downcase}/v1.4/"
  end

  def get_mastery_region_url(region)
    region_location = {
      "BR" => "BR1",
      "EUNE" => "EUN1",
      "EUW" => "EUW1",
      "JP" => "JP1",
      "KR" => "KR1",
      "LAN" => "LA1",
      "LAS" => "LA2",
      "NA" => "NA1",
      "OCE" => "OC1",
      "TR" => "TR1",
      "RU" => "RU1",
      "PBE" => "PBE1"
    }

    "https://#{region.downcase}.api.pvp.net/championmastery/location/#{region_location[region]}/"
  end
end