require 'netologiest/resource'
require 'netologiest/resources/course'
require 'netologiest/resources/lesson'
require 'netologiest/config'
require 'netologiest/exceptions'
require 'netologiest/version'

# Ruby client for Netology API
module Netologiest
  def self.config
    @config ||= Config.new
  end
end
