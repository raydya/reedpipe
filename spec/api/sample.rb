require 'spec_helper'

describe Reedpipe::Api::Sample do
	include Rack::Test::Methods

	def app
		Reedpipe::App
	end

	it 'hello' do
		get '/hello'
		expect(last_response.status).to eq(200)
		#expect(last_response.body).to eq({ ping: 'pong' }.to_json)
	end
end