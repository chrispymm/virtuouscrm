module Virtuous
    class Relationship < Client

        class << self

            # Gets the relationships for the specified contact
            # @param contact_id [Int] The Reference Id of the contact to retrieve.
            # @param filter [String] String to filter by.
            # @param skip [Int] Number of records to skip (pagination start number).
            # @param take [Int] Number of records to take (records per page).
            # @return [Array] related to specified contact
            def find_by_contact( contact_id, filter='', skip=0, take=10 )
                params = {
                    skip:  skip,
                    take:  take
                }
                params[:filter] = filter unless filter.empty?
                parse_list(connection.get("/Relationship/ByContact/#{contact_id}", params ).body )
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
                body = attributes.to_json
                contact_method = Virtuous::Relationship.new JSON.parse(connection.put("/Relationship/#{id}", body).body)
            end

            # Creates a new relationship
            # @param id [Int] the id of the contact relationship created
            # @param attributes [Hash] attributes of the contact relationship created
            # @return [Virtuous::Relationship] the created contact relationship
            def create( attributes = {} )
                body = attributes.to_json
                contact_method = Virtuous::Relationship.new JSON.parse(connection.post("/Relationship", body).body)
            end

            private
            
            def parse_list(json)
                JSON.parse(json)["list"].map { |relationship| new relationship }
            end            

        end

    end
    
end
