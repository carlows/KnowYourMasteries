# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'riot_api_requests'

api = RiotApiRequests.new

champion_data = api.request_champion_data

champion_data["data"].values.each do |champ|
  Champion.create(id: champ["id"], champion_id: champ["id"], name: champ["name"], key: champ["key"])
end