module Netologiest
  class HttpClient
    class << self
      def get(url, params: {})
        uri = URI(url)
        uri.query = URI.encode_www_form(params)
        response = Response.new(Net::HTTP.get_response(uri))
        if block_given?
          yield response
        else
          response
        end
      end
    end

    class Response
      attr_reader :body, :code

      def success?
        response.is_a?(Net::HTTPSuccess)
      end

      private

      attr_reader :response

      def initialize(response)
        @response = response
        @body = response.body
        @code = response.code.to_i
      end
    end
  end
end
