require 'bitrise/test_device'
require 'json'


module Bitrise
  class Client
    module TestDevice

      # List registered test devices of all members of a specified Bitrise app
      #
      # @param app_slug [String] Your bitrise app slug
      #
      # @return [Array<Bitrise::TestDevice>
      def test_devices(app_slug: nil)
        raise ArgumentError, 'App slug required. You must specify by \'app_slug:\'' unless app_slug

        response = client.get do |request|
          request.url "/v0.1/apps/#{app_slug}/test-devices"
          request.headers['Content-Type'] = 'application/json'
        end

        JSON.parse(response.body)['data'].map do |device|
          Bitrise::TestDevice.new(device)
        end
      end
    end
  end
end
