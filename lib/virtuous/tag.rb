module Virtuous
    class Tag < Client

        class << self

            # Gets the tags for the current organization
            # @param skip [Int] Number of records to skip (pagination start number).
            # @param take [Int] Number of records to take (records per page).
            # @return [Array] an array of [Vituouscrm::Tag] objects
            def all(skip=0, take=100)
                params = {
                    skip:   skip,
                    take:   take
                }
                parse_list(connection.get("/Tag", params).body)
            end

            def search(search="", skip=0,take=10)
                body = {
                    search: search
            }.to_json
                params = {
                    skip:   skip,
                    take:   take
                }
                parse_list( connection.post("/Tag/Search", body, params).body )
            end

            private

            def parse_list(json)
                JSON.parse(json)["list"].map { |tag| new tag }
            end

        end

    end
end