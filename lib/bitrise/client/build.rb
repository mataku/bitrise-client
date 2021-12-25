require 'json'
require 'bitrise/build_trigger_result'

module Bitrise
  class Client
    module Build
      # Trigger a build of your bitrise app
      #
      # @param app_slug [String] Your bitrise app slug
      # @param build_params [Hash] Bulld params so that Bitrise can identify which workflow to run. Specify a branch or tag or workflow_id.
      #
      # @return [Bitrise::BuildTriggerResult]
      #
      # See: https://devcenter.bitrise.io/en/api/triggering-and-aborting-builds.html#triggering-a-new-build-with-the-api
      def trigger_build(app_slug: nil, build_params: {})
        raise ArgumentError, 'App slug required. You must specify by \'app_slug:\'' unless app_slug
        raise ArgumentError, 'No value found for \'branch\' or \'tag\' or \'workflow_id\'' if build_params.empty?

        response = client.post do |request|
          request.url "/v0.1/apps/#{app_slug}/builds"
          request.headers['Content-Type'] = 'application/json'
          request.body = {
            hook_info: {
              type: 'bitrise'
            },
            build_params: build_params
          }.to_json
        end

        result = JSON.parse(response.body)
        BuildTriggerResult.new(result)
      end
    end
  end
end
