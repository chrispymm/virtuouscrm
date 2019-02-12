require "httparty"
require 'logger'
require 'active_record'

require "virtuous/version"
require "virtuous/configuration"
require "virtuous/client"
require "virtuous/connection"
require "virtuous/error"
require "virtuous/virtuous_token_error"

require "virtuous/contact"
require "virtuous/contact_address"
require "virtuous/contact_individual"
require "virtuous/contact_method"
require "virtuous/contact_note"
require "virtuous/contact_tag"
require "virtuous/organization"
require "virtuous/organization_group"
require "virtuous/relationship"
require "virtuous/token"
require "virtuous/tag"

require "virtuous/railtie" if defined?(Rails)

require "app/models/application_record"
require "app/models/virtuous_access_token"

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
