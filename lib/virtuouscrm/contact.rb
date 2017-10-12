module Virtuouscrm
    class Contact < Client

        class << self

            # Get a contact. 
            # @param id [Int] The ContactID of the contact to retrieve.
            # @return [Virtuouscrm::Contact]
            def find(id)
                contact = Virtuouscrm::Contact.new JSON.parse(connection.get("/Contact/#{id}").body)
            end

            # Get a contact by reference source and reference id
            # @param reference_source [String] The Reference Source of the contact to retrieve.
            # @param reference_id [Int] The Reference Id of the contact to retrieve.
            # @return [Virtuouscrm::Contact]
            def find_by_reference_source(reference_source, reference_id)
                contact = Virtuouscrm::Contact.new JSON.parse(connection.get("/Contact/#{reference_source}/#{reference_id}").body)
            end

            # Get a contact by reference source and reference id
            # @param reference_id [Int] The Reference Id of the contact to retrieve.
            # @return [Virtuouscrm::Contact]
            def find_by_reference(reference_id)
                contact = Virtuouscrm::Contact.new JSON.parse(connection.get("/Contact/ByReference/#{reference_id}").body)
            end

            # Get a contacts by tag id
            # @param tag_id [Int] The Reference Id of the contact to retrieve.
            # @param filter [String] String to filter by.
            # @param skip [Int] Number of records to skip (pagination start number).
            # @param take [Int] Number of records to take (records per page).
            # @return [Array] An array of Virtuouscrm::Contact records
            def find_by_tag_id(tag_id, filter='', skip=0, take=10 )
                params = {
                    filter: filter,
                    skip:   skip,
                    take:   take
                }
                parse_list(connection.get("/Contact/ByTag/#{tag_id}", params).body)
            end

            # Update a contact by id
            # @param id [Int] the id of the contact to update
            # @param attributes [Hash] attributes of the contact to update
            # @return [Virtuouscrm::Contact] the updated contact
            def update( id, attributes = {} )
                body = attributes
                contact = Virtuouscrm::Contact.new JSON.parse(connection.put("/Contact/#{id}", body).body)
            end

            # Create a new contact
            # @param id [Int] the id of the contact to update
            # @param attributes [Hash] attributes of the contact to create
            # @return [Virtuouscrm::Contact] the new contact
            def new(attributes)
                body = attributes
                contact = Virtuouscrm::Contact.new JSON.parse(connection.post("/Contact", body).body)
            end


            # Get Custom Fields for contacts
            # @return [Array]
            def custom_fields
                custom_fields = JSON.parse(connection.get("/Contact/CustomFields").body )
            end

            # Get prefixes for contacts
            # @return [Array]
            def prefixes
                prefixes = JSON.parse(connection.get("/Contact/Prefixes").body )
            end

            # Get types for contacts
            # @return [Array]
            def types
                types = JSON.parse(connection.get("/Contact/Types").body )
            end

            # Get available query options for contacts
            # @return [Array]
            def query_options
                options = JSON.parse(connection.get("/Contact/QueryOptions").body )
            end

            # Gets the activity for the contacts the (current) user is following.
            # @param skip [Int] Number of records to skip (pagination start number).
            # @param take [Int] Number of records to take (records per page).
            # @return [Array] An array of activity entries
            def activity(skip=0, take=10)
                params = {
                    skip:   skip,
                    take:   take
                }
                activity = JSON.parse(connection.get("/Contact/QueryOptions", params).body )
            end

            # Gets the contacts the (current) user is following.
            # @param skip [Int] Number of records to skip (pagination start number).
            # @param take [Int] Number of records to take (records per page).
            # @return [Array] An array of activity entries
            def activity(skip=0, take=10)
                params = {
                    skip:   skip,
                    take:   take
                }
                activity = JSON.parse(connection.get("/Contact/QueryOptions", params).body )
            end

            private
            
            def parse_list(json)
                JSON.parse(json)["list"].map { |contact| new contact }
            end

        end
    end
end