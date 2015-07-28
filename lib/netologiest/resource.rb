require 'json'
require 'rest-client'
require 'active_support'

module Netologiest
  # This class describe client for
  # Netology API. It contains finder actions
  # and special handlers methods
  class Resource
    class << self
      attr_accessor :resource_name
    end

    attr_reader :token, :token_expire

    def initialize
      authorize!
    end

    def self.list
      new.list
    end

    def self.detail(id)
      new.detail(id)
    end

    def list
      handle_list(
        get(
          build_url(self.class.resource_name)
        )
      )
    end

    def detail(id)
      handle_detail(
        get(
          build_url(self.class.resource_name, id)
        )
      )
    end

    # rubocop:disable Metrics/AbcSize, Metrics//MethodLength
    def authorize!
      url = build_url('gettoken')
      params = { client_secret: Netologiest.config.api_key }
      RestClient.get(url, params: params) do |response, _request, _result|
        case response.code
        when 200
          body = JSON.parse(response.body)
          @token_expire = Time.now.to_i + body.fetch('expires_in').to_i
          @token = body['access_token']
        when 401
          fail Netologiest::Unauthorized, response.body
        else
          response
        end
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics//MethodLength

    def token_expired?
      return true unless token_expire.present?
      token_expire < Time.now.to_i
    end

    def handle_list(_response); end

    def handle_detail(_response); end

    protected

    def build_url(*args)
      File.join(Netologiest.config.api_url, *args.map(&:to_s))
    end

    # rubocop:disable Metrics/MethodLength
    def get(url, options = {})
      params = { token: token }.merge!(options)

      RestClient.get(url, params: params) do |response, _request, _result|
        if response.code == 401
          begin
            authorize!
            params[:token] = token
            return RestClient.get(url, params: params)
          rescue RestClient::Unauthorized
            raise Netologiest::Unauthorized, response.body
          end
        end
        response
      end
    end
    # rubocop:enable Metrics/MethodLength
  end
end
