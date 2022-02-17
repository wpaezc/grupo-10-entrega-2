module Repositories
  class Agenda
    attr_reader :conn

    def initialize
      @conn = Faraday.new(url: ENV["AGENDA_HOST"]) do |f|
        f.request :json
        f.response :json
      end
    end

    def create(seller_id, agenda_data)
      conn.post("/agenda/sellers/#{seller_id}", agenda_data)
    end

    def delete(seller_id, order_id)
      conn.delete("/agenda/sellers/#{seller_id}/order/#{order_id}")
    end
  end
end