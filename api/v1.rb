module Reedpipe
	module Api
		class V1 < Grape::API
			format :json
			version ['v2','v1'], using: :path, format: :json, cascade: true
      prefix :api

			desc 'Returns the current API version ,v1'
			get do
				{version: 'v1'}
			end

			get :hello do
				{hello: 'world'}
			end

			get :sample do
				user = OpenStruct.new
        user.id = 1
        user.name = 'testname'
				present user, :with => Reedpipe::Entities::SampleEntity
        body()
			end

		end
	end
end