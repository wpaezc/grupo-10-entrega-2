class Seller
  @@repository = Repositories::Seller.new
  attr_accessor :body, :success, :status

  def initialize(body: {}, success: false, status: 500)
    @body = body
    @success = success
    @status = status
  end

  def self.get_by_product_id(item)
    product_id = item ? item["uuid"] : ""
    response = @@repository.get_by_product_id(product_id)
    new(body: response.body, success: response.success?, status: response.status)
  end
end