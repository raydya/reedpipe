module Reedpipe
	module Api
		class V2 < Grape::API
			format :json
			version :v2, using: :path, format: :json, cascade: true
      prefix :api

			desc 'Returns the current API version ,v2'
			get do
				{version: 'v2'}
      end

      desc 'takes a lot of time'
      get 'long' do
        { reasonably_static: Time.now.to_i }
      end

		end
	end
end