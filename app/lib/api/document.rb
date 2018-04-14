module Api
  class Document
    include HTTParty
    base_uri ENV['API_URL']

    def self.all(doc_id)
      self.get("/documents?doc_id=#{doc_id}")
    end
  end
end
