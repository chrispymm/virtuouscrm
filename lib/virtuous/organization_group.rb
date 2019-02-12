module Virtuous
  class OrganizationGroup < Client
    class << self

      def all(skip=0, take=10)
        params = {
          skip: skip,
          take: take
        }
        parse_list(connection.get("/OrganizationGroup" ).body)
      end

      def find(id)
        Virtuous::OrganizationGroup.new JSON.parse(connection.get("/OrganizationGroup/#{id}").body)
      end

      def find_by_contact(contactId)
        JSON.parse( connection.get("/OrganizationGroup/ByContact/#{contactId}").body ).map{|org_group| new org_group }
      end

      def contacts(id, skip=0, take=10)
        params = {
          skip: skip,
          take: take
        }
        parse_contacts(connection.get("/OrganizationGroup/#{id}/contacts", params).body)
      end

      def add_contact(id, contactId)
        response = connection.put("/OrganizationGroup/#{id}/contacts/#{contactId}")
        status = response.respond_to?(:status) ? response.status : response.code
      end

      def remove_contact(id,contactId)
        response = connection.delete("/OrganizationGroup/#{id}/contacts/#{contactId}")
        status = response.respond_to?(:status) ? response.status : response.code
      end

      private

      def parse_list(json)
        JSON.parse(json)["list"].map { |organization_group| new organization_group }
      end

      def parse_contacts(json)
        JSON.parse(json)["list"].map { |contact| Virtuous::Contact.new( contact) }
      end

    end
  end
end
