module Api
  class Topic
    include HTTParty
    base_uri ENV['API_URL']

    def self.all
      self.get('/topics')
    end
  end
end
