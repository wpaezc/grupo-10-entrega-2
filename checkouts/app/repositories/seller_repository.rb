module Repositories
  class Seller
    attr_reader :conn

    def initialize
      @conn = Faraday.new(url: ENV["SELLERS_HOST"]) do |f|
        f.request :json
        f.response :json
      end
    end

    def get_by_product_id(product_id)
      conn.get("/sellers/item/#{product_id}")
    end
  end
end