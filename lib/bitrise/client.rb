require 'bitrise/client/build'
require 'faraday'

module Bitrise
  class Client
    include Bitrise::Client::Build

    def initialize(options = {})
      @api_host = options[:host] || 'https://api.bitrise.io'
      @timeout = options[:timeout] || 30
      @open_timeout = options[:open_timeout] || 30
    end

    def client
      @client ||= Faraday.new(url: @api_host) do |faraday|
        faraday.options.timeout        = @timeout
        faraday.options.open_timeout   = @open_timeout
        faraday.options.params_encoder = Faraday::FlatParamsEncoder
        faraday.response :logger if ENV['DEBUG']

        faraday.adapter Faraday.default_adapter
      end
    end
  end
end
