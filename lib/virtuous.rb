require "httparty"

require "virtuous/version"
require "virtuous/configuration"
require "virtuous/client"
require "virtuous/connection"
require "virtuous/error"

require "virtuous/contact"
require "virtuous/contact_address"
require "virtuous/contact_individual"
require "virtuous/contact_method"
require "virtuous/contact_note"
require "virtuous/contact_tag"
require "virtuous/relationship"
require "virtuous/tag"

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
