require "httparty"

require "Virtuous/version"
require "Virtuous/configuration"
require "Virtuous/client"
require "Virtuous/connection"
require "Virtuous/error"

require "Virtuous/contact"
require "Virtuous/tag"

module Virtuous
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
