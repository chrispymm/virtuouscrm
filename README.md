# Virtuous

This gem is a wrapper around the Virtuous CRM API.  It currently does not provide 100% coverage of API methods - only the ones I have needed so far.  It is slightly opinionated in that it ignores any totals returned from list/search endpoints and just returns the results body.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'Virtuous'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install Virtuous

Then run

    $ rails g virtuous:install

To install the migrations and default config into initializers/Virtuous.rb

Migrate the database to run the migrations and create the required databse table.

    $ rake db:migrate


## Usage

To start using Virtuous you need to generate your access token.

    $ rails g virtuous:token

When prompted enter your virtuous email address and password.  Note, these credentials will not be stored, they are used just once to generate the first token.  From this point forward will always use the refresh token provided with your access token.

If the token generation is successful it will return you the refresh_token associated with the access token.

This refresh string needs to be made available to the gem in your app within the Virtuous.rb found in the initializers directory in your app.

**N.B. Do Not paste your refresh token directly into the initializer file. This token should never be committed to Version Control.**  

The recommended way to do this would be to use Rails secrets.yml.  Or you can make it available via an ENV variable.

e.g. in `config/secrets.yml`
```
development
  virtuous_refresh_token: xxxx... your refresh string here ...xxx
```

then in `initializers/virtuous.rb`

```ruby
Virtuous.configure do |config|
  ...
  config.refresh_token = Rails.application.secrets.virtuous_refresh_token
  ...
end
```

#### Setup a scheduled job.

In order to ensure your tokens are refreshed automatically you need to setup a recurring job that calls

```
rake virtuous:tokens:refresh
```

How you implement this is up to you.  However the simplest method is probably to use the [Whenever](https://github.com/javan/whenever) gem. e.g. in `config/schedule.rb`

```ruby
every 12.hours do
  rake "virtuous:tokens:refresh_token"
end
```

#### Exceptions

If there is an error refreshing the token, then the gem will rescue the error and raise a `Virtuous::VirtuousTokenError`. This will contain a `:data` attribute containing the original exception information.  It is up to you to implement what you would like to happen on this Error (e.g. notifications etc.).  If you have exception logging within your app already you may need to take no action.  However if you wanted to implement a notification on this specific action you could do something like the following:

In `controllers/ApplicationController.rb`

```ruby
rescue_from Virtuous::VirtuousTokenError, with: notify_virtuous_token_failure
def notify_virtuous_token_failure(exception)
  # Implement a mailer to send yourself an email.  You can access the following methods on e
  #  - exception.message => generic message for the error
  #  - exception.data => the original exception that was raised.
end

```

#### Making API Calls.

In your app you can simply call any of the methods within the gem with the required attributes.  e.g.

```ruby
#Setup the attributes to send to the api
attrs = { contactType: "Household", name: "Fred Flintstone" ...  }
#Make a call using the gem
result = Virtuous::Contact.create(attrs)
```

This will return an instance of `Virtuous::Contact` on success. This is an OpenStruct containing the attributes of the returned Contact object from the api.

On failure the Virtuous API will return a 4XX or 5XX status.  The gem will respond to this with a `Virtuous::Error` and provide the message from the api
Again, you probably want to rescue from this exception in your app, and provide some notification/log of the error.

The gem api methods generally fall into two categories:  Individual object actions and list actions.  Individual object method calls should always respond with an instance of their of their api class.  e.g. as above a call to `Virtuous::Contact.create` will respond with an instance of `Virtuous::Contact`.  Similarly a call to `Virtuous::ContactNote.find` will respond with an instance of `Virtuous::ContactNote`.  List actions will generally respond with an Array of instances.  e.g. `Virtuous::Contact.search` will respond with `[<Virtuous::Contact>, <Virtuous::Contact>, ...]`.  However the Virtuous API is inconsistent, and sometimes does not respond with instances. So consult the api documentation carefully to see what response to expect.

#### Config Options

**refresh_token:**
The refresh token provided by `rails g virtuous:token`.  ** This should not be added directly to the config!** Tt should be a reference to secrets entry or ENV var.

**refresh_threshold:**
The period of time before the token expires that a token refresh will be performed.  Should be a period of time e.g. `1.day` or `24.hours`.  Default is `72.hours`.  This gives time to act if for any reason a token refresh fails.

**env:**
The environment you wish the gem to run under e.g. 'development', 'production' etc.  Defaults to `Rails.env`

**http_debug:**
Whether or not you wish to have curl debug output to stdout.  Useful in development for debugging api calls.  However, the output is fairly verbose, so you may wish to turn it off.

**http_log:**
Whether to store http debug output in a log file.

**http_log_format:**
Either `:curl` or `:apache`.  Curl is very verbose.  Apache is a nice compact output per call.

**logger:**
Possibility to provide your own logger for Virtuous Logs.

**error_with**
Can be set to `:log` or `raise`. `:raise` with raise a `Virtuous::Error`, log will add an entry in the log (level=error).


## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://bitbucket.org/acts29/Virtuous.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
