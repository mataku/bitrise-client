require 'json'

module Bitrise
  class Client
    module Build
      
      # Trigger a build of your bitrise app
      #
      # @param app_slug [String] Your bitrise app slug
      # @param build_trigger_token [String] Build Trigger token of your app
      # 
      # See: https://devcenter.bitrise.io/api/build-trigger/
      def trigger_build(app_slug = nil, build_trigger_token = nil, options = {})
        @app_slug = app_slug || raise('App slug required.')
        @build_trigger_token = build_trigger_token || raise('Build trigger token required.')

        response = client.post do |request|
          request.url "/app/#{@app_slug}/build/start.json"
          request.headers['Content-Type'] = 'application/json'
          request.body = {
            hook_info: {
              type: 'bitrise',
              build_trigger_token: @build_trigger_token
            },
            build_params: options[:build_params]
          }.to_json
        end

        check_http_status(response)

        JSON.parse(response.body)
      end

      def check_http_status(response)
        case response.status
        when 200..299 then
          return
        else
          raise JSON.parse(response.body)['message']
        end
      end
    end
  end
end
