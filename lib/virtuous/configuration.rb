module Virtuous
    class Configuration
        #attr_accessor :token
        attr_accessor :refresh_token
        attr_accessor :refresh_threshold
        attr_accessor :logger
        attr_accessor :error_with
        attr_accessor :http_debug
        attr_accessor :http_log
        attr_accessor :http_log_format
        attr_accessor :env

        def initialize
          @env = 'development'
          @http_debug = ( @env == 'development' ? true : false )
          @http_log = ( @env == 'development' ? true : true )
          @http_log_format = :apache
          @logger = ( @env == 'development' ? ::Logger.new($stdout) : ::Logger.new('log/virtuous.log') )
        end

        def test?
          !!@test
        end




    end
end
