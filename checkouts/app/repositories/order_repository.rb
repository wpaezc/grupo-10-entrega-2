module Repositories
  class Order
    attr_reader :conn

    def initialize
      @conn = Faraday.new(url: ENV["ORDERS_HOST"]) do |f|
        f.request :json
        f.response :json
      end
    end

    def create(order_data)
      conn.post("/orders", order_data)
    end

    def delete(order_id)
      conn.delete("/orders/#{order_id}")
    end
  end
end