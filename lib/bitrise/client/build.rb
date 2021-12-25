require 'bitrise/build_trigger_result'
require 'json'

module Bitrise
  class Client
    module Build
      # Trigger a build of your bitrise app
      #
      # @param app_slug [String] Your bitrise app slug
      # @param build_params [Hash] Bulld params so that Bitrise can identify which workflow to run. Specify a branch or tag or workflow_id at least.
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

    # Abort a build of your bitrise app
    #
    # @param app_slug [String] Your bitrise app slug
    # @param build_slug [String] Bitrise build slug which you want to abort
    #
    # @param options [Hash]
    # @option opts [String]  :abort_reason        A reason for aborting the build
    # @option opts [Boolean] :abort_with_success  Treat as a successful or not
    # @option opts [Boolean] :skip_notifications  Set true if you want to send email notifications about aborting by Bitrise
    #
    # See: https://devcenter.bitrise.io/en/api/triggering-and-aborting-builds.html#aborting-a-build
    def abort_build(app_slug: nil, build_slug: nil, options: {})
      raise ArgumentError, 'App slug required. You must specify by \'app_slug:\'' unless app_slug
      raise ArgumentError, 'Build slug required. You must specify by \'build_slug:\'' unless build_slug

      client.post do |request|
        request.url "/v0.1/apps/#{app_slug}/builds/#{build_slug}/abort"
        request.headers['Content-Type'] = 'application/json'
        request.body = options.to_json
      end
    end
  end
end
