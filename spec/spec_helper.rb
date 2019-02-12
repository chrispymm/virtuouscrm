require "bundler/setup"
require "Virtuous"
require "vcr"
#require "webmock/rspec"

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

#load 'spec/support/schema'
load File::expand_path('spec/support/schema.rb')


Virtuous.configure do |config|
  #config.env = 'development'
  config.http_debug = true
  #Turns on/off http request log
  config.http_log = true
  #HTTP Log format values :apache or :curl (:curl gives very verbose output - as per debug log above)
  config.http_log_format = :curl
  #Log File
  config.logger = ::Logger.new('virtuous.log')
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

  #config.before(:suite) do
    #VCR.use_cassette("token") do
      #Virtuous::VirtuousAccessToken.get_initial("{email}", "{password}")
    #end
  #end

  config.before(:each) do
    access_token = OpenStruct.new(token: "xZWwyjMsUbsGaLXqsVzNBrJhkJgkuWvshN2ZvPgn7RLvm2gj1V2gSoHDYtQEHSoJ3IwbX0mZw8VRNP4qIecC0MIRtf1h-Lq_-Sa6m4jfUWDS3TPDCygd9uX_ZFxdiqqpYuhhoO-gsjz4d9eqQ6H7qF0nZi6ndHcfn9UJH3EWRJNE-z1SSXNapZScTBoBp7oJVE3vxjyMMfVWkbuqscvz8BSgxLclhYi0u660ZelwZSZOAylgqQ5onxK9-vuHm75lrhMASvaevyjkFeyzerPSEmbd-kntCbv3BVVjMaQCTADCezGuqHrSgh-OkhwtEU-WHpF-ra3ayap6NZnVkLBetgkft91U_93K055kDNEYroYTms1mBA9l5JJVenU4wWLRNrDJo_TyNzLDrvyxR2qIas0iejZDXUfWGrcRQYIFeSelpDIRzOw9dMCgmYC48sgS_VbHWdu5hHhELycSqwIm6mwQIJgUMf2i-y9SIDylODXuZ6w7ZPUkovgE1wg_YQlosVTmeLgcOlW2kDpv7Tjnvjynd7ke5m2SQKRsEwytGuusICXgJq94zB6hi48J6SKseo3XUg", active: true)
    #Virtuous::VirtuousAccessToken.current = "#{Virtuous::VirtuousAccessToken.current}"
    allow(Virtuous::VirtuousAccessToken).to receive(:current).and_return(access_token)
    #allow(Virtuous::VirtuousAccessToken.current).to receive(:token).and_return()
  end



end
