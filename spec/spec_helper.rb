require "bundler/setup"
require "Virtuous"
require "vcr"
#require "webmock/rspec"

Virtuous.configure do |config|
  config.token = "v1iO46y9qiqyXiz8D4ZTugnpIVIv6KXEsReKZ8EuOFHJT29thIXQW1XUWbtykR66_4UtSoQIaUTTjuFcFY5iidQin8SE17IF7PebkqgeC0UPT-Z4G4v6fPVJ1IDLGxCSTfYe_CZ3tlSnQdzcT7ICmEAPI6i_GsL4TL4uCPFfmIgB0Cqn68kh3BBKtMCOWbsYdhP_U4OJDlCgYBG3AkKqpgDAH0H9Cb1DJO1x3o4TVn06_QQHDLDHfAccZHn2lUPbB_7s6f7UtKc_X_YmAcTMUFOd8POeyF3mNRbOY6xSM0cMvhLnPj93yEA_WI75WB-swJyHILIyv6ccUUZ6KmS16SAWOqzjKho9ccQg6-TKCoezQ2yvDlLrsA2H-V7X09PU7MWX6mn9nyGD1SDmt_5y-skiPhekNLoYnvp-2LOo619-HuVOChY0-_N3r5k6xwiimX797esP7KZIvveU5oOYjRY1QuFb0S8eg5aIZi9apWjBN9WfX4XfTcwTSVisZo0O3Xs34NyVERTvMfL-CX3sOoKSOB5hnc2V1gy7c8m08mD0jyRh"
end

VCR.configure do |config|
 config.cassette_library_dir = 'spec/cassettes'
 config.hook_into :webmock
 config.allow_http_connections_when_no_cassette = true
 config.default_cassette_options = { :record => :all }
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end



end
