module Virtuous
    class ContactTag < Client

        class << self
            
            # Gets the tags for the specified contact
            # @param id [Int] The contactID of the specified contact tag
            # @return [String] related to specified contact tag
            def find(id, attributes={}, skip=0, take=10 )
                body = attributes
                params = {
                    skip:   skip,
                    take:   take
                }
                contact_method = JSON.parse(connection.get("/ContactTag/ByContact/#{id}", body, params ).body )
            end   

            # Deletes the specified contact tag 
            # @param id [Int] The contactID of the specified contact tag to delete
            # @return status [String] HTTP status code  200 / 400 etc
            def delete(id)
                response = connection.delete("/ContactTag/#{id}")
                status = response.respond_to?(:status) ? response.status : response.code
            end

            # Create a new contact tag for the specified contact
            # @param id [Int] the id of the contact tag created
            # @param attributes [Hash] attributes of the contact tag created
            # @return [Virtuous::Contact] the created contact tag
            def create( attributes = {} )
                body = attributes
                contact_method = Virtuous::ContactAddress.new JSON.parse(connection.post("/ContactTag", body).body)
            end

            private
            
            def parse_list(json)
                JSON.parse(json)["list"].map { |contact| new contact }
            end            

        end

    end
    
end
