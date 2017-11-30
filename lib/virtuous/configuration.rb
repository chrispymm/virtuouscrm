module Virtuous
    class Configuration 
        attr_accessor :token
        attr_accessor :logger
        attr_accessor :http_debug
        attr_accessor :http_log
        attr_accessor :env
    
        def initialize
          @env = 'development'
          @http_debug = ( @env == 'development' ? true : false )
          @http_log = ( @env == 'development' ? true : true )
          @logger = ( @env == 'development' ? ::Logger.new($stdout) : ::Logger.new('virtuous.log') )
        end
    
        def test?
          !!@test
        end




    end
end