require 'httpclient'
require_relative 'errors'

module Squid
  class Reporter

    def initialize
      @client = HTTPClient.new
      @client.connect_timeout = 1
      @client.receive_timeout = 1

      @url = Squid.endpoint
      @header = { 'Content-Type' => 'application/json' }
    end

    def report(path, data)
      post @url + path, header: @header, body: JSON.dump(data)
    end

    private

    def post(url, options)
      @client.post(url, options)
    rescue Errno::ECONNREFUSED,
           HTTPClient::ConnectTimeoutError,
           HTTPClient::ReceiveTimeoutError => error
      raise ConnectionError
    end

  end
end
