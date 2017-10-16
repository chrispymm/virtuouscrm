module Virtuous
    class ContactMethod < Client

        class << self
            
            # Gets the types of contact methods
            def types
                contact_method = JSON.parse(connection.get("/ContactMethod/Types").body )
            end

            # Gets the types of contact methods related to the specified contact method type
            # @param contact_method [String] ContactMethod type to fetch related content methods for.
            # @return [String] related to specified contact method type
            def related_types(contact_method)
                params = {
                    name: contact_method
                }
                contact_method_related = JSON.parse(connection.get("/ContactMethod/RelatedTypes", params ).body )
            end

            # Deletes the specified contact method 
            # @param id [Int] The contactID of the specified contact method to delete
            # @return status [String] HTTP status code  200 / 400 etc
            def delete(id)
                response = connection.delete("/ContactMethod/#{id}")
                status = response.respond_to?(:status) ? response.status : response.code
            end

            # Gets the specified contact method
            # @param contactMethodId [Int] The contactID of the specified contact method
            # @return [String] related to specified contact method
            def find(id)
                contact_method = JSON.parse(connection.get("/ContactMethod/#{id}").body )
            end            

            # Updates the specified contact method
            # @param id [Int] the id of the contact method to update
            # @param attributes [Hash] attributes of the contact method to update
            # @return [Virtuous::Contact] the updated contact method
            def update( id, attributes = {} )
                body = attributes
                contact_method = Virtuous::ContactAddress.new JSON.parse(connection.put("/ContactMethod/#{id}", body).body)
            end

            # Create a new contact method for the specified contact individual
            # @param id [Int] the id of the contact method created
            # @param attributes [Hash] attributes of the contact method created
            # @return [Virtuous::Contact] the created contact method
            def create( attributes = {} )
                body = attributes
                contact_method = Virtuous::ContactAddress.new JSON.parse(connection.post("/ContactMethod", body).body)
            end

            private
            
            def parse_list(json)
                JSON.parse(json)["list"].map { |contact| new contact }
            end            

        end

    end
    
end
