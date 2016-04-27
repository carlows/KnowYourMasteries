class Champion < ActiveRecord::Base
  has_many :champion_masteries
  has_many :champion_stats
end
