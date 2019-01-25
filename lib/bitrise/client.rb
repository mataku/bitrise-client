module Bitrise
  class Client
    def initialize(options = {})
      @api_host = options[:host] || 'https://api.bitrise.io/v0.1'
      @timeout = options[:timeout] || 30
      @api_token = options[:api_token] || raise ArgumentError.new('API token required')
      @open_timeout = options[:open_timeout] || 30
    end

    private

    def client
      @client ||= Faraday.new(url: @api_host) do |faraday|
        faraday.adapter Faraday.default_adapter
        faraday.options.timeout        = @timeout
        faraday.options.open_timeout   = @open_timeout
        faraday.response :logger
      end
    end
  end
end
