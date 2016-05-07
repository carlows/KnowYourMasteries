module RiotApi
  class SummonerNotFoundException < StandardError
  end

  class RateLimitExceededException < StandardError
  end

  class RiotServerErrorException < StandardError
  end

  class SummonerHasNoMasteryException < StandardError
  end
end