require 'rspec'
require 'netologiest'
require 'webmock/rspec'
require 'helpers/webmock_helpers'

begin
  require "pry-byebug"
rescue LoadError
end

ENV["NETOLOGIEST_CONF"] = File.expand_path("../fixtures/netologiest_test.yml", __FILE__)

RSpec.configure do |config|
  config.mock_with :rspec
  include NetologiestWebMock
end
