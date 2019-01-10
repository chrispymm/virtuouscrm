module Virtuous
  class VirtuousAccessToken < Virtuous::ApplicationRecord
    attr_accessor :current_token

    default_scope -> { order(created_at: :desc) }
    scope :active, -> { where(active: true) }

    class << self
      def current
        self.active.first
      end

      #def current_token
        #@current_token ||= self.current.reload.try(:token)
      #end

      #def current_token=(token_string)
        #@current_token = token_string
      #end


      def get_initial(email, password)
        response = Virtuous::Token.get(email, password)
        expiry = self.set_expiry(response.expires_in)
        token = Virtuous::VirtuousAccessToken.new(token: response.access_token, expiry: expiry, active: true )
        if token.save
          return { status: "SUCCESS", message: response.refresh_token }
        else
          return { status: "ERROR", message: "There was an error saving the token." }
        end
      end

      def refresh
        current_VAT = self.current
        if Time.now > (current_VAT.expiry - Virtuous.configuration.refresh_threshold)
          response = Virtuous::Token.refresh
          expiry = self.set_expiry(response.expires_in)
          new_VAT = Virtuous::VirtuousAccessToken.new(token: response.access_token, expiry: expiry, active: true )
          begin
            ActiveRecord::Base.transaction do
              if new_VAT.save
                current_VAT.update_columns( active: false )
                current_VAT.reload
                new_VAT.reload
                #Virtuous::VirtuousAccessToken.connection.clear_query_cache
                Virtuous::VirtuousAccessToken.current.reload
                #self.current_token = new_VAT.token
                #Virtuous::VirtuousAccessToken.remove_instance_variable(:@current_token)
              end
            end
          rescue => e
            raise VirtuousTokenError.new(data: e), "There was an error refreshing your Virtuous access token"
          end
        end
      end

      def set_expiry(expires_in)
        Time.now + expires_in.seconds
      end
    end
  end
end
