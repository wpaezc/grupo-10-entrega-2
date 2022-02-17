class Payment
  @@repository = Repositories::Payment.new
  attr_accessor :body, :success, :status, :repository

  def initialize(body: {}, success: false, status: 500)
    @body = body
    @success = success
    @status = status
  end

  def self.create(payment_data)
    response = @@repository.create(payment_data)
    new(body: response.body, success: response.success?, status: response.status)
  end
end