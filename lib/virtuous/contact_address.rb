module Virtuous
    class ContactAddress < Client

        class << self

            # Deletes the specified contact address. 
            # @param id [Int] The contactID of the contact to delete
            # @return status [String] HTTP status code  200 / 400 etc
            def delete(id)
                response = connection.delete("/ContactAddress/#{id}")
                status = response.respond_to?(:status) ? response.status : response.code
            end

            # Gets the specified contact address
            # @param id [Int] The ContactID of a specific contact
            # @return [Virtuous::Contact] address of contact
            def find(id)
                contact_address = Virtuous::ContactAddress.new JSON.parse(connection.get("/ContactAddress/#{id}").body)
            end

            # Updates the specified contact address
            # @param id [Int] the id of the contact address to update
            # @param attributes [Hash] attributes of the contact to update
            # @return [Virtuous::Contact] the updated contact
            def update( id, attributes = {} )
                body = attributes
                contact_address = Virtuous::ContactAddress.new JSON.parse(connection.put("/ContactAddress/#{id}", body).body)
            end

            # Gets the contact addresses for the specified contact
            # @param contactId [Int] The ContactID of a specific contact
            # @return [Virtuous::Contact]
            def find_by_contact(contactId)
                contact_address = Virtuous::ContactAddress.new JSON.parse(connection.get("/ContactAddress/#{contactId}").body)
            end

            # Creates a new contact address
            # @param attributes [Hash] attributes of the contact to create
            # @return [Virtuouscrm::Contact] the new contact
            def create(attributes={})
                body = attributes
                contact_address = Virtuous::ContactAddress.new JSON.parse(connection.post("/ContactAddress", body ).body )    
            end

            private
            
            def parse_list(json)
                JSON.parse(json)["list"].map { |contact| new contact }
            end

        end
    end
end