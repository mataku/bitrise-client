require 'faraday'
require 'bitrise/error'

module Bitrise
  class Client
    module Middleware

      class ErrorHandler < Faraday::Response::Middleware

      # @param [Faraday::Response]
        def on_complete(response)
          case response.status
          when 400..599
            raise Bitrise::Error.new(JSON.parse(response.body)['message'])
          end
        end
      end
    end
  end
end
