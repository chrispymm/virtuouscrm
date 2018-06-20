RSpec.describe Virtuous::ContactAddress do


    describe "#find" do
        let(:contact_id) { 33 }
        let(:nonexistant_id)  { 0000 }

        it "return a contact address object" do
            VCR.use_cassette("contact_address") do
                @contact_address = Virtuous::ContactAddress.find(contact_id)
            end
            expect(@contact_address).to be_instance_of Virtuous::ContactAddress
        end

        it "returns a contact address matching id" do
            VCR.use_cassette("contact_address") do
                @contact_address = Virtuous::ContactAddress.find(contact_id)
            end
            expect(@contact_address.id).to eq(contact_id)
        end

        it "errors if the contact doesn't exist" do
            expect {
                VCR.use_cassette("contact_not_found") do
                    @contact_address = Virtuous::ContactAddress.find(nonexistant_id)
                end
            }.to raise_error Virtuous::Error
        end

    end

    describe "#update" do
        let(:contact_id) {2526}
        let(:attributes) { { label: "Imported Address", city: "Loughborough" } }

        it "requres attributes" do
            expect {
                @contact_address = Virtuous::ContactAddress.update(contact_id)
            }.to raise_error Virtuous::Error
        end

        it "returns the contact address record" do
            VCR.use_cassette("contact_address_update") do
                @contact_address = Virtuous::ContactAddress.update(contact_id, attributes)
            end
            expect(@contact_address).to be_instance_of Virtuous::ContactAddress
            expect(@contact_address.id).to eq(contact_id)
        end

        it "updates the attributes" do
            VCR.use_cassette("contact_address_update") do
                @contact_address = Virtuous::ContactAddress.update(contact_id, attributes)
            end
            expect(@contact_address.city).to eq(attributes[:city])
        end

    end


    describe "#find_by_contact" do
        let(:contactId) {2526}
        it "returns an array of contact address object" do
            VCR.use_cassette("contact_address") do
                @contact_address = Virtuous::ContactAddress.find_by_contact(contactId)
            end
            expect(@contact_address).to be_a Array
            # expect(@contact_address.first).to be_instance_of Virtuous::ContactAddress
        end

    end


end
