require 'anyway'

module Netologiest
  # :nodoc:
  class Config < Anyway::Config
    attr_config :api_key,
                api_url: "http://dev.netology.ru/content_api"
  end
end
