RSpec.describe Virtuous::OrganizationGroup do

  describe "#all" do
    it "returns an array of Organization Groups" do
      #puts "Current Token: #{Virtuous::VirtuousAccessToken.current.token}"

      VCR.use_cassette("organization_groups") do
        @org_groups = Virtuous::OrganizationGroup.all
      end



      expect(@org_groups).to be_a Array
      expect(@org_groups.first).to be_a Virtuous::OrganizationGroup
    end
  end

  describe "#find" do
    it "finds an organization group by id" do
      org_group_id = 1
      VCR.use_cassette("organization_groups") do
        @org_group = Virtuous::OrganizationGroup.find(org_group_id)
      end

      expect(@org_group).to be_instance_of Virtuous::OrganizationGroup
    end
  end

  describe "#find_by_contact" do
    it "returns an arganizationgroup" do
      contact_id = 1661
      VCR.use_cassette("organization_groups") do
        @org_group = Virtuous::OrganizationGroup.find_by_contact(contact_id)
      end

      expect(@org_group).to be_a Array
      expect(@org_group.first).to be_instance_of Virtuous::OrganizationGroup
    end
  end

  describe "#contacts" do
    it "returns array of contacts" do
      org_group_id = 1
      VCR.use_cassette("organization_groups") do
        @contacts = Virtuous::OrganizationGroup.contacts(org_group_id)
      end

      expect(@contacts).to be_a Array
      expect(@contacts.first).to be_instance_of Virtuous::Contact
    end
  end

  describe "#add_contact" do
    it "returns success" do
      contact_id = 3
      org_group_id = 1
      VCR.use_cassette("organization_groups") do
        @contact = Virtuous::OrganizationGroup.add_contact( org_group_id, contact_id)
      end

      expect(@contact).to eq(200)
    end
  end

  describe "#remove_contact" do
    it "returns success" do
      contact_id = 3
      org_group_id = 1
      VCR.use_cassette("organization_groups") do
        @contact = Virtuous::OrganizationGroup.remove_contact( org_group_id, contact_id)
      end

      expect(@contact).to eq(200)
    end
  end


end

