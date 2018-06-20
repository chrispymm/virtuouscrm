Virtuous.configure do |config|
    #Refresh token for getting new Virtuous Tokens
    config.refresh_token = Rails.application.secrets.virtuous_refresh_token
    #How long before the token expires shoudl we attempt to refresh the token
    config.refresh_threshold = 72.hours
    #By default if development http_debug: true, http_log: false
    config.env = Rails.env
    #Turns on/off stdout debug info for HTTP Requests
    config.http_debug = false
    #Turns on/off http request log
    config.http_log = true
    #HTTP Log format values :apache or :curl (:curl gives very verbose output - as per debug log above)
    config.http_log_format = :apache
    #If an API error occurs e.g. 4XX / 5XX from Virtuous, what shoudl we do? Default is :log, Tests expect :raise - in production you probably want :log
    config.error_with = :log
    #Log File
    config.logger = ( Rails.env.development? ? Rails.logger :  ::Logger.new('log/virtuous.log') )
end
