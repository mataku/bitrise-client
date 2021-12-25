require 'bitrise/client/build'
require 'bitrise/client/middleware/error_handler'
require 'faraday'

module Bitrise
  class Client
    include Bitrise::Client::Build

    def initialize(access_token: nil, options: {})
      raise ArgumentError.new('You must specify Bitrise access token by `access_token:`.') unless access_token
      @api_host = options[:host] || 'https://api.bitrise.io'
      @timeout = options[:timeout] || 30
      @open_timeout = options[:open_timeout] || 30
      @access_token = access_token
    end

    def client
      @client ||= Faraday.new(url: @api_host) do |faraday|
        faraday.options.timeout        = @timeout
        faraday.options.open_timeout   = @open_timeout
        faraday.options.params_encoder = Faraday::FlatParamsEncoder
        faraday.use Bitrise::Client::Middleware::ErrorHandler
        faraday.response :logger if ENV['DEBUG']
        faraday.headers['Authorization'] = @access_token

        faraday.adapter Faraday.default_adapter
      end
    end
  end
end
