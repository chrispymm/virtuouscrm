require "bundler/setup"
require "Virtuous"
require "vcr"
#require "webmock/rspec"

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

#load 'spec/support/schema'
load File::expand_path('spec/support/schema.rb')


Virtuous.configure do |config|
  config.http_debug = true
  #Turns on/off http request log
  config.http_log = false
  #HTTP Log format values :apache or :curl (:curl gives very verbose output - as per debug log above)
  config.http_log_format = :apache
  #Log File
  config.logger = nil
  config.error_with = :raise
end

VCR.configure do |config|
 config.cassette_library_dir = 'spec/cassettes'
 config.hook_into :webmock
 config.allow_http_connections_when_no_cassette = true
 config.default_cassette_options = { :record => :new_episodes }
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:suite) do
    VCR.use_cassette("token") do
      Virtuous::VirtuousAccessToken.get_initial("{email}", "{password}")
    end
  end

  config.before(:each) do
    Virtuous::VirtuousAccessToken.current_token = "#{Virtuous::VirtuousAccessToken.current_token}"
  end



end
