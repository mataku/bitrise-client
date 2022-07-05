require 'bitrise/app'
require 'json'

module Bitrise
  class Client
    module App

      # List all the apps available for the authenticated account, including those that are owned by other users or Organizations.
      #
      # @param sort_by [String] Order of the applications: sort them based on when they were created or the time of their last build
      #   Available values : last_build_at, created_at
      # @param next [String] Slug of the first app in the response
      # @param limit [Integer] Max number of elements per page (default: 50)
      #
      # @return [App]
      def apps(sort_by: nil, _next: nil, limit: nil)
        response = client.get do |request|
          request.url "/v0.1/apps"
          request.params = {
            sort_by: sort_by,
            next: _next,
            limit: limit,
          }.compact
          request.headers['Content-Type'] = 'application/json'
        end

        result = JSON.parse(response.body)
        AppResponse.new(result)
      end
    end
  end
end
