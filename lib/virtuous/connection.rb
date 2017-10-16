module Virtuous #:nodoc:
    
  class Connection
    include HTTParty

    # The version of the API being used if unspecified.
    DEFAULT_VERSION  = "v1"

    # Base URI for the Unsplash API..
    DEFAULT_API_BASE_URI   = "https://api.virtuoussoftware.com/api"


    # Create a Connection object.
    # @param version [String] The API version to use.
    # @param api_base_uri [String] Base URI at which to make API calls.
    # @param oauth_base_uri [String] Base URI for OAuth requests.
    def initialize(version: DEFAULT_VERSION, api_base_uri: DEFAULT_API_BASE_URI)
      @token              = Virtuous.configuration.token
      @api_version        = version
      @api_base_uri       = api_base_uri

      Virtuous::Connection.base_uri @api_base_uri
    end


    # Perform a GET request.
    # @param path [String] The path at which to make ther request.
    # @param params [Hash] A hash of request parameters.
    def get(path, params = {})
      request :get, path, params
    end

    # Perform a PUT request.
    # @param path [String] The path at which to make ther request.
    # @param params [Hash] A hash of request parameters.
    def put(path, body = {}, params = {})
      request :put, path, body, params
    end

    # Perform a POST request.
    # @param path [String] The path at which to make ther request.
    # @param body [Hash] A hash of body parameters.
    # @param params [Hash] A hash of query parameters.
    def post(path, body = {}, params = {})
      request :post, path, body, params
    end

    # Perform a DELETE request.
    # @param path [String] The path at which to make ther request.
    # @param params [Hash] A hash of request parameters.
    def delete(path, body={}, params = {})
      request :delete, path, body, params
    end

    private

    def request(verb, path, body = {}, params = {})
      raise ArgumentError.new "Invalid http verb #{verb}" if ![:get, :post, :put, :delete].include?(verb)

      headers = {
      "Accept-Version" => @api_version,
      "Authorization" => "Bearer #{@token}"
      }
      if verb == :get 
        response =  self.class.public_send verb, path, query: params, headers: headers
      else
        response =  self.class.public_send verb, path, body: body, query: params, headers: headers
      end

    #   if response.headers["Warning"]
    #     Virtuous.configuration.logger.warn response.headers["Warning"]
    #   end

      status_code = response.respond_to?(:status) ? response.status : response.code

      if !(200..299).include?(status_code)
        if !response.body.empty?
          body = JSON.parse(response.body)
          message = "Status: #{status_code}\n\r Message: #{body["message"]}" #body["error"] || body["errors"].join(" ") 
        else
          message ="Status: #{status_code}"
        end
        raise Virtuous::Error.new message
      end

      response
    end

  end
end