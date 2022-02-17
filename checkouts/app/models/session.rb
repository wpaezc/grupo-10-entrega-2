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


#session = Session.new(
#  body: {"id"=>"959b013c-4a1c-4c19-823a-435227c1aa0d", "random"=>"11851.91991187565", "time_created"=>"Wed, 16 Feb 2022 01:54:09 GMT", "time_updated"=>nil, "user_id"=>"10996aa7-88b1-4721-84a1-0c58ffc15fe8"}
#)

#params = {"item" => {"uuid" => "143ef613-6d62-4158-a2ed-6164887b3146"} }
#params = {"item" => {"uuid" => "042908f7-d4fa-4c75-90ab-3ab57808e841"} }
#params = {"item" => {"uuid" => "61d78280-dffa-4a98-bc64-d155f54082b2"} }

#o = Checkouts::Orchestrator.process_new_order(session, params)

#p o.status
#p "###################"
#p o.body
