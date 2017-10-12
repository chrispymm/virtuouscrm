require "httparty"

require "virtuouscrm/version"
require "virtuouscrm/configuration"
require "virtuouscrm/client"
require "virtuouscrm/connection"
require "virtuouscrm/error"

require "virtuouscrm/contact"
require "virtuouscrm/tag"

module Virtuouscrm
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
