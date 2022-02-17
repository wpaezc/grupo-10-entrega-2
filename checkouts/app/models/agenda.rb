class Agenda
  @@repository = Repositories::Agenda.new

  attr_accessor :body, :success, :status, :repository

  def initialize(body: {}, success: false, status: 500)
    @body = body
    @success = success
    @status = status
  end

  def self.create(seller_id, agenda_data)
    response = @@repository.create(seller_id, agenda_data)
    new(body: response.body, success: response.success?, status: response.status)
  end

  def destroy
    response = @@repository.delete(@body['sellerId'], @body["orderId"])
    response
  end
end