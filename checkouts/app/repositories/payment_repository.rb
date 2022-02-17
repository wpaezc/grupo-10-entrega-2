module Repositories
  class Payment
    attr_reader :conn

    def initialize
      @conn = Faraday.new(url: ENV["PAYMENTS_HOST"]) do |f|
        f.request :json
        f.response :json
      end
    end

    def create(payment_data)
      conn.post("/payments", payment_data)
    end
  end
end