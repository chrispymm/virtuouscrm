module Virtuous
    class Token < Client

      class << self

        def get(email, password)
          body = "grant_type=password&username=#{email}&password=#{password}"
          response = Virtuous::Token.new( JSON.parse( connection.class.public_send(:post, "https://api.virtuoussoftware.com/Token", body: body).body ) )
        end

        def refresh
          body = "grant_type=refresh_token&refresh_token=#{Virtuous.configuration.refresh_token}"
          response = Virtuous::Token.new( JSON.parse( connection.class.public_send(:post, "https://api.virtuoussoftware.com/Token", body: body).body ) )
        end

      end

    end
end
