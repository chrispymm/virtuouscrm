module Virtuous
    class Configuration 
        attr_accessor :token
        #attr_accessor :application_secret
        #attr_accessor :application_redirect_uri
        #attr_accessor :logger
        #attr_accessor :utm_source
        attr_writer   :test
    
        def initialize
          @test = true
          # @logger = Logger.new(STDOUT)
        end
    
        def test?
          !!@test
        end


    end
end