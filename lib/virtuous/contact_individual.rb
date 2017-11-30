module Virtuous
    class ContactIndividual < Client

        class << self

            # Deletes the specified contact individual. 
            # @param id [Int] The ContactID of the contact to delete
            # @return status [String] HTTP status code  200 / 400 etc
            def delete(id)
                response = connection.delete("/ContactIndividual/#{id}")
                status = response.respond_to?(:status) ? response.status : response.code
            end

            # Gets the specified contact individual
            # @param id [Int] The ContactID of a specific contact
            # @return [Virtuous::Contact]
            def find(id)
                contact_individual = Virtuous::ContactIndividual.new JSON.parse(connection.get("/ContactIndividual/#{id}").body)
            end

            # Updates the specified contact individual
            # @param id [Int] the id of the contact to update
            # @param attributes [Hash] attributes of the contact to update
            # @return [Virtuous::Contact] the updated contact
            def update( id, attributes = {} )
                body = attributes.to_json
                contact_individual = Virtuous::ContactIndividual.new JSON.parse(connection.put("/ContactIndividual/#{id}", body).body)
            end

            # Gets the contact individuals for the specified contact
            # @param contactId [Int] The ContactID of a specific contact
            # @return [Hash] 
            def find_by_contact(contactId)
                contact_individuals = JSON.parse(connection.get("/ContactIndividual/ByContact/#{contactId}").body)
                contact_individuals.map { |individual| Virtuous::ContactIndividual.new( individual ) }
            end

            # Gets the avatar for a specified contact individual
            # @param id [Int] The ContactID of a specific contact
            # @return [Virtuous::Contact]
            def find_avatar(id)
                contact_avatar = Virtuous::ContactIndividual.new JSON.parse(connection.get("/ContactIndividual/#{id}/Avatar").body)
                # gave a bad response 400
            end

            # Updates the avatar for a specified contact individual
            # @param id [Int] The ContactID of a specific contact
            # @return [Virtuous::Contact]
            def update_avatar(id)
                contact_avatar = Virtuous::ContactIndividual.new JSON.parse(connection.post("/ContactIndividual/#{id}/Avatar").body)
            end

            # Get Custom Fields for contact individuals
            # @return [Array]
            def custom_fields
                custom_fields = JSON.parse(connection.get("/ContactIndividual/CustomFields").body )
            end

            # Creates a new contact individual
            # @param attributes [Hash] attributes of the contact to create
            # @return [Virtuouscrm::Contact] the new contact
            def create(attributes={})
                body = attributes.to_json
                contact_individual = Virtuous::ContactIndividual.new JSON.parse(connection.post("/ContactIndividual", body ).body )    
            end

            private
            
            def parse_list(json)
                JSON.parse(json)["list"].map { |contact| new contact }
            end

        end
    end
end