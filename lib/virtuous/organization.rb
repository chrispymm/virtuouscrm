module Virtuous
    class Organization < Client

        class << self

            # Gets all organizations a user belongs to
            # @return [Array <Organization>] Array of Organizations 
            def all
                contact =  parse_list( connection.get("/Organization/").body )
            end

            # gets the current organization
            # @return [Organization]
            def current
                organization = Virtuous::Organization.new JSON.parse(connection.get("/Organization/Current").body)
            end

            # sets the current organization
            # @return status [Int] HTTP Status Code 200 or 400
            def switch(organizationUserId)
                body = {
                    OrganizationUserId: organizationUserId 
                }
                response = connection.put("/Organization/Switch", body.to_json )
                status = response.respond_to?(:status) ? response.status : response.code
            end


            private
            
            def parse_list(json)
                JSON.parse(json).map { |organization| new organization }
            end



        end

    end
end