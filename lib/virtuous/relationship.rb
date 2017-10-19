module Virtuous
    class Relationship < Client

        class << self

            # Gets the relationships for the specified contact
            # @param id [Int] The contactID of the contact to return relationships for
            # @return [Array] related to specified contact
            def find_by_contact( id, skip=0, take=10 )
                params = {
                    skip:  skip,
                    take:  take
                }
                parse_list(connection.get("/Relationship/ByContact/#{id}", params ).body )
            end            
            
            # Gets the types of relationships
            def types
                contact_method = JSON.parse(connection.get("/Relationship/Types").body )
            end

            # Deletes the specified relationship
            # @param id [Int] The contactID of the specified relationship to delete
            # @return status [String] HTTP status code  200 / 400 etc
            def delete(id)
                response = connection.delete("/Relationship/#{id}")
                status = response.respond_to?(:status) ? response.status : response.code
            end

            # Updates the specified relationship
            # @param id [Int] the id of the relationship to update
            # @param attributes [Hash] attributes of the relationship to update
            # @return [Virtuous::Relationship] the updated relationship
            def update( id, attributes = {} )
                body = attributes
                contact_method = Virtuous::Relationship.new JSON.parse(connection.put("/Relationship/#{id}", body).body)
            end

            # Creates a new relationship
            # @param id [Int] the id of the contact relationship created
            # @param attributes [Hash] attributes of the contact relationship created
            # @return [Virtuous::Relationship] the created contact relationship
            def create( attributes = {} )
                body = attributes
                contact_method = Virtuous::Relationship.new JSON.parse(connection.post("/Relationship", body).body)
            end

            private
            
            def parse_list(json)
                JSON.parse(json)["list"].map { |relationship| new relationship }
            end            

        end

    end
    
end
