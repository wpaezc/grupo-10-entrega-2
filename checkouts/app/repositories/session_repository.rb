module Repositories
  class Session
    attr_reader :conn

    def initialize
      @conn = Faraday.new(url: ENV['MONOLITH_HOST']) do |f|
        f.request :json
        f.response :json
      end
    end

    def get(session_id)
      conn.get("/sesion/#{session_id}")
    end
  end
end