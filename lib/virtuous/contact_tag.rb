module Virtuous
    class ContactTag < Client

        class << self
            
            # Gets the tags for the specified contact
            # @param id [Int] The contactID of the specified contact tag
            # @return [String] related to specified contact tag
            def find_by_contact(id, skip=0, take=10 )
                params = {
                    skip:   skip,
                    take:   take
                }
                parse_list(connection.get("/ContactTag/ByContact/#{id}", params ).body )
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
            # @return [Virtuous::ContactTag] the created contact tag
            def create( attributes = {} )
                body = attributes
                contact_method = Virtuous::ContactAddress.new JSON.parse(connection.post("/ContactTag", body).body)
            end

            private
            
            def parse_list(json)
                JSON.parse(json)["list"].map { |contact_tag| new contact_tag }
            end            

        end

    end
    
end
