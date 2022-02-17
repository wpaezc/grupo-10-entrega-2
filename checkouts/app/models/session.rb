class Session
  @@repository = Repositories::Session.new

  attr_accessor :body, :success, :status, :repository

  def initialize(body: {}, success: false, status: 500)
    @body = body
    @success = success
    @status = status
  end

  def self.get(session_id)
    response = @@repository.get(session_id)
    new(body: response.body, success: response.success?, status: response.status)
  end
end
