class Order
  @@repository = Repositories::Order.new
  attr_accessor :body, :success, :status, :repository

  def initialize(body: {}, success: false, status: 500)
    @body = body
    @success = success
    @status = status
  end

  def self.create(order_data)
    response = @@repository.create(order_data)
    new(body: response.body, success: response.success?, status: response.status)
  end

  def destroy
    response = @@repository.delete(@body["orderId"])
    response
  end
end

