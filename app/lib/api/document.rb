
module Api
  class Document
    include HTTParty
    base_uri ENV['API_URL']

    def self.all
      self.get('/documents')
    end
  end
end
