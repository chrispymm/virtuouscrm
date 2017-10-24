module Virtuous
    class ContactNote < Client

        class << self
            
            # Gets the important notes for the specified contact
            # @param id [Int] The contactID of the contact to return important notes for
            # @return [Array] related to specified contact note
            def find_important_for_contact( id, skip=0, take=10 )
                params = {
                    skip:  skip,
                    take:  take
                }
                parse_list(connection.get("/ContactNote/Important/ByContact/#{id}", params ).body )
            end

            # Gets the notes for the specified contact
            # @param id [Int] The contactID of the contact to return notes for
            # @return [Array] related to specified contact note
            def find_by_contact( id, skip=0, take=10 )
                params = {
                    skip:  skip,
                    take:  take
                }
                parse_list(connection.get("/ContactNote/ByContact/#{id}", params ).body )
            end

            # Gets the types of contact notes
            def types
                contact_note = JSON.parse(connection.get("/ContactNote/Types").body )
            end

            # Deletes the specified contact note 
            # @param id [Int] The contactID of the specified contact note to delete
            # @return status [String] HTTP status code  200 / 400 etc
            def delete(id)
                response = connection.delete("/ContactNote/#{id}")
                status = response.respond_to?(:status) ? response.status : response.code
            end

            # Gets the specified note
            # @param id [Int] The contactID of the contact to return notes for
            # @return [Virtuous::ContactNote]
            def find( id )
                contact_note = Virtuous::ContactNote.new JSON.parse(connection.get("/ContactNote/#{id}" ) )
            end

            # Updates the specified contact note
            # @param id [Int] the id of the contact note to update
            # @param attributes [Hash] attributes of the contact note to update
            # @return [Virtuous::ContactNote] the updated contact note
            def update( id, attributes = {} )
                body = attributes
                contact_note = Virtuous::ContactNote.new JSON.parse(connection.put("/ContactNote/#{id}", body).body)
            end

            # Create a new contact note for the specified contact individual
            # @param id [Int] the id of the contact note created
            # @param attributes [Hash] attributes of the contact note created
            # @return [Virtuous::ContactNote] the created contact note
            def create( attributes = {} )
                body = attributes
                # contact_note = Virtuous::ContactNote.new JSON.parse(connection.post("/ContactNote", body).body)
                response = connection.post("/ContactNote", body )
                status = response.respond_to?(:status) ? response.status : response.code
            end

            # Posts the email as a contact note
            # @body from [String] attributes of the contact note created
            # @body to [String] attributes of the contact note created
            # @body subject [String] attributes of the contact note created
            # @body message [String] attributes of the contact note created 
            # @return [Virtuous::ContactNote] the email
            def create_from_email( from="", to="", subject="", message="" )
                body = {
                    fromEmail: from,
                    toEmail: to,
                    subject: subject,
                    body: message
                }
                contact_note = Virtuous::ContactNote.new JSON.parse(connection.post("/ContactNote/Email", body).body)
                # response = JSON.parse(connection.post("/ContactNote/Email", body).body)
                # status = response.respond_to?(:status) ? response.status : response.code
            end

            private
            
            def parse_list(json)
                JSON.parse(json)["list"].map { |contact_note| new contact_note }
            end            

        end

    end
    
end