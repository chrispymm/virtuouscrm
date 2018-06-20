require 'rails/generators'

module Virtuous
  class TokenGenerator < Rails::Generators::Base

    #argument :email, type: :string, required: true, desc: "Virtuous user email address"
    #argument :password, type: :string, required: true, desc: "Virtuous user password"

    def token
      existing_token = Virtuous::VirtuousAccessToken.active.first
      return say("You alrady have a Virtuous Token. You should refresh instead.") if existing_token
      email = ask("Enter your virtuous user email address")
      password = ask("Enter your virtuous user password")
      result = Virtuous::VirtuousAccessToken.get_initial(email, password)
      if result[:status] == "SUCCESS"
        say( "SUCCESS! Your token was generated and saved.", :green )
        say( "Your refresh token is shown below.  This should be stored in your rails secrets.yml and referenced in your Virtuous.rb initializer file.", :yellow)
        say( "#{result[:message]}", :white)
      else
        say( "#{result[:message]}", :red )
      end
    end

  end
end
