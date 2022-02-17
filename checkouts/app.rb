require 'sinatra'
require 'sinatra/reloader'
require 'dotenv'
require 'faraday'
require 'byebug'
require 'rack'
require 'rack/contrib'

Dotenv.load

require './app/repositories/session_repository'
require './app/repositories/order_repository'
require './app/repositories/payment_repository'
require './app/repositories/agenda_repository'
require './app/repositories/seller_repository'

require './app/models/session'
require './app/models/payment'
require './app/models/order'
require './app/models/agenda'
require './app/models/seller'
require './app/services/orchestrator'

class Checkout < Sinatra::Base
  use Rack::JSONBodyParser 

  configure :development do
    register Sinatra::Reloader
  end

  before do
    content_type :json
  end

  post '/checkouts' do
    session = Session.get(params[:session_id])

    if session.success
      orchestator = Services::Orchestrator.process_new_order(session, params)

      response.status = orchestator.status
      response.body = orchestator.body.to_json
    else
      response.status = session.status
      response.body = session.body.to_json
    end
  end
end
