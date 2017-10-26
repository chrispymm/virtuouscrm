module Virtuous
    class Contact < Client

        class << self

            # Get a contact. 
            # @param id [Int] The ContactID of the contact to retrieve.
            # @return [Virtuous::Contact]
            def find(id)
                contact = Virtuous::Contact.new JSON.parse(connection.get("/Contact/#{id}").body)
            end

            # Get a contact by reference source and reference id
            # @param reference_source [String] The Reference Source of the contact to retrieve.
            # @param reference_id [Int] The Reference Id of the contact to retrieve.
            # @return [Virtuous::Contact]
            def find_by_reference_source(reference_source, reference_id)
                contact = Virtuous::Contact.new JSON.parse(connection.get("/Contact/#{reference_source}/#{reference_id}").body)
            end

            # Get a contact by reference source and reference id
            # @param reference_id [Int] The Reference Id of the contact to retrieve.
            # @return [Virtuous::Contact]
            def find_by_reference(reference_id)
                contact = Virtuous::Contact.new JSON.parse(connection.get("/Contact/ByReference/#{reference_id}").body)
            end

            # Get a contacts by tag id
            # @param tag_id [Int] The Reference Id of the contact to retrieve.
            # @param filter [String] String to filter by.
            # @param skip [Int] Number of records to skip (pagination start number).
            # @param take [Int] Number of records to take (records per page).
            # @return [Array] An array of Virtuous::Contact records
            def find_by_tag_id(tag_id, filter='', skip=0, take=10 )
                params = {
                    skip:   skip,
                    take:   take
                }
                params[:filter] = filter unless filter.empty?
                parse_list( connection.get("/Contact/ByTag/#{tag_id}", params).body )
            end

            # Update a contact by id
            # @param id [Int] the id of the contact to update
            # @param attributes [Hash] attributes of the contact to update
            # @return [Virtuous::Contact] the updated contact
            def update( id, attributes = {} )
                body = attributes
                contact = Virtuous::Contact.new JSON.parse(connection.put("/Contact/#{id}", body).body)
            end

            # Create a new contact
            # @param id [Int] the id of the contact to update
            # @param attributes [Hash] attributes of the contact to create
            # @return [Virtuouscrm::Contact] the new contact
            def create(attributes={})
                body = attributes
                contact = Virtuous::Contact.new JSON.parse(connection.post("/Contact", body).body)
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
            # @return [Hash]
            def query_options
                options = JSON.parse(connection.get("/Contact/QueryOptions").body )
            end

            # Gets the activity for the contacts the (current) user is following.
            # @param skip [Int] Number of records to skip (pagination start number).
            # @param take [Int] Number of records to take (records per page).
            # @return [Array] An array of contacts (with limited data)
            def activity(skip=0, take=10)
                params = {
                    skip:   skip,
                    take:   take
                }
                activity = parse_list(connection.get("/Contact/Activity", params).body )
            end

            # Gets the contacts the (current) user is following.
            # @param skip [Int] Number of records to skip (pagination start number).
            # @param take [Int] Number of records to take (records per page).
            # @return [Array] An array of contacts
            def following(skip=0, take=10)
                params = {
                    skip:   skip,
                    take:   take
                }
                parse_list(connection.get("/Contact/Following", params).body )
            end

            # Posts and creates a contact batch that will be processed for changes and duplicates.
            # @param contacts [Array] and array  of the contact objects [OpenStruct] to queue/process
            # @return status [String] HTTP status code  200 / 400 etc
            def batch(contacts=[])
                body = {
                    contacts: contacts 
                }
                response = connection.post("/Contact/Batch", body )
                status = response.respond_to?(:status) ? response.status : response.code
            end

            
            # Find Contacts near a location
            # @param lat [Int] latitude
            # @param lng [Int] logitude
            # @param distance [Int] distance in miles for search radius
            # @param skip [Int] Number of records to skip (pagination start number).
            # @param take [Int] Number of records to take (records per page).
            # @return [Array]  of randomly structured contact information (for some reason)
            def search_nearby(lat=0, lng=0, distance=0, skip=0, take=10)
                body = {
                    latitude: lat,
                    longitude: lng,
                    distanceInMiles: distance
                }
                params = {
                    skip:   skip,
                    take:   take
                }
                response = JSON.parse(connection.post("/Contact/Proximity", body, params).body)
            end

            # Find all contacts that match, fully or partially, the given search string
            # @param search [String] The search query.
            # @param skip [Int] Number of records to skip (pagination start number).
            # @param take [Int] Number of records to take (records per page).
            # @return [Array] An array of Virtuous::Contact records
            def search(search="", skip=0, take=10 )
                body = {
                    search: search
                }
                params = {
                    skip:   skip,
                    take:   take
                }
                parse_list(connection.post("/Contact/Search", body, params).body)
            end

            # Find all contacts that match, fully or partially, the given query attributes
            # 
            # Query attributes shoudl be made up of elements from Virtuous::Contact.query_options
            #
            # @param query [Hash] The query attributes.
            # @param skip [Int] Number of records to skip (pagination start number).
            # @param take [Int] Number of records to take (records per page).
            # @return [Array] An array of Virtuous::Contact records
            def query(query={}, skip=0, take=10 )
                body = query.to_json
                params = {
                    skip:   skip,
                    take:   take
                }
                headers = { "Content-Type" => "application/json" }
                parse_list(connection.post("/Contact/Query", body, params, headers).body)
            end


            private
            
            def parse_list(json)
                JSON.parse(json)["list"].map { |contact| new contact }
            end

        end
    end
end